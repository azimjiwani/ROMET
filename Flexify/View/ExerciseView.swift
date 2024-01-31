//
//  ExerciseView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//


// var quickPose = QuickPose(sdkKey: "01HHQA2TDGWH12D8HWFYXY6HA3") // register for your free key at https://dev.quickpose.ai

import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct ExerciseView: View {
    var viewModel: ExerciseViewModel
    var quickPose = QuickPose(sdkKey: Constants.sdkKey)
    
    var point1: QuickPose.Landmarks.Body {
        switch viewModel.exercise?.type {
        case .wristFlexion, .wristExtension, .ulnarDeviation, .radialDeviation:
            return QuickPose.Landmarks.Body.elbow(side: .left)
        case .pronation, .supination, .none:
            return QuickPose.Landmarks.Body.elbow(side: .left)
        }
    }
    
    var point2: QuickPose.Landmarks.Body {
        switch viewModel.exercise?.type {
        case .wristFlexion, .wristExtension, .ulnarDeviation, .radialDeviation:
            return QuickPose.Landmarks.Body.wrist(side: .left)
        case .pronation, .supination, .none:
            return QuickPose.Landmarks.Body.wrist(side: .left)
        }
    }
    
    var point3: QuickPose.Landmarks.Hand {
        switch viewModel.exercise?.type {
        case .wristFlexion, .wristExtension:
            return QuickPose.Landmarks.Hand.PINKY_FINGER_MCP
        case .ulnarDeviation, .radialDeviation:
            return QuickPose.Landmarks.Hand.MIDDLE_FINGER_TIP
        case .pronation, .supination, .none:
            return QuickPose.Landmarks.Hand.PINKY_FINGER_MCP
        }
    }
    
    @State private var overlayImage: UIImage?
    @State private var leftElbowPoint = CGPoint(x: 1080/2, y: 1920/2)
    @State private var leftWristPoint = CGPoint(x: 1080/2, y: 1920/2)
    @State private var leftMCP3Point = CGPoint(x: 1080/2, y: 1920/2)
    @State private var angle: CGFloat = 0.0
    
    // State variables for rep counting
    @State private var repCount: Int = 0
    @State private var isRepInProgress: Bool = false
    @State private var previousAngle: CGFloat = 0.0
    
    // State variables for set counting
    @State private var setCount: Int = 0
    
    @State private var maxAngle: Float = 0.0
    
    @State private var isVisible = false
    
    func computeRep() {
        // Rep counting logic
        if isRepInProgress {
            if abs(angle) >= 0 && abs(angle) <= 10 {
                // Rep is completed
                repCount += 1
                isRepInProgress = false
            }
        } else {
            // Start rep if the angle exceeds 20 degrees
            if angle > 20 {
                isRepInProgress = true
            }
        }
        
        previousAngle = angle
    }
    
    func computeSet() {
        if repCount == viewModel.exercise?.reps {
            setCount += 1
            repCount = 0
        }
    }
    
    func prepareForUpload(){
        if let reps = viewModel.exercise?.reps {
            viewModel.exercise?.completedReps = (setCount * reps) + repCount
        }
        viewModel.exercise?.completedSets = setCount
        viewModel.exercise?.maxAngle = maxAngle
        viewModel.uploadExercise()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack{
                    Spacer()
                    Button {
                        print("Info button tapped")
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
                .offset(y: -32)
                    
                if let reps = viewModel.exercise?.reps, let sets = viewModel.exercise?.sets {
                    Text("Sets: \(sets) | Reps: \(reps)")
                        .offset(y: -32)
                }
                
                ZStack(alignment: .top) {
                    QuickPoseCameraView(useFrontCamera: true, delegate: quickPose, videoGravity: .resizeAspect)
                    QuickPoseOverlayView(overlayImage: $overlayImage, contentMode: .fit)
                }
                .offset(y: -32)
                .overlay(alignment: .topLeading) {
                    Circle()
                        .position(x: leftElbowPoint.x, y: leftElbowPoint.y)
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color.green.opacity(1.0))
                    Circle()
                        .position(x: leftWristPoint.x, y: leftWristPoint.y)
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color.green.opacity(1.0))
                    Circle()
                        .position(x: leftMCP3Point.x, y: leftMCP3Point.y)
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color.green.opacity(1.0))
                }
                .frame(width: geometry.size.width)
                .edgesIgnoringSafeArea(.all)
                .onChange(of: isVisible) { newValue in
                    if !newValue {
                        // View is no longer visible, perform cleanup or stop ongoing processes
                        quickPose.stop()
                        print("stopped")
                    }
                }
                .onAppear {
                    isVisible = true
                    print("started")
                    quickPose.start(features: [], onFrame: { status, image, features, feedback, landmarks in
                        overlayImage = image
                        if case .success = status, let landmarks = landmarks {
                            let leftElbow = landmarks.landmark(forBody: point1)
                            let leftWrist = landmarks.landmark(forBody: point2)
                            
                            leftElbowPoint = leftElbow.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
                            leftWristPoint = leftWrist.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
                            
                            // Left mcp3
                            if let leftMCP3 = landmarks.landmark(forLeftHand: point3) {
                                leftMCP3Point = leftMCP3.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
                            }
                            
                            if leftElbow.visibility >= 0.9 && leftWrist.visibility >= 0.9 {
                                
                                // Compute joint angle
                                angle = 180 - (atan2(leftMCP3Point.y - leftWristPoint.y, leftMCP3Point.x - leftWristPoint.x) - atan2(leftElbowPoint.y - leftWristPoint.y, leftElbowPoint.x - leftWristPoint.x)) * 180 / .pi
                                
                                if angle < 0 {
                                    angle += 360
                                    if angle > 180 {
                                        angle = 360 - angle
                                    }
                                } else if angle > 180 {
                                    angle = 360 - angle
                                }
                                
                                //                                maxAngle = max(maxAngle, angle)
                                
                                computeRep()
                                computeSet()
                            }
                            
                        } else {
                            // Show error feedback
                        }
                    })
                }
                .onDisappear {
                    isVisible = false
                    quickPose.stop()
                    print("stopped")
                }
                HStack {
                    Text("Angle: \(max(angle, 0))")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("Reps: \(repCount)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("Sets: \(setCount)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
                NavigationLink(destination: ExerciseSummaryView(viewModel: viewModel)) {
                    Text("Complete Exercise")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .frame(height: 40)
                        .cornerRadius(20)
                }
                Spacer()
            }
        }
        .navigationBarTitle(viewModel.exercise?.name ?? "no name")
    }
}
