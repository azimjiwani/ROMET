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

enum API_KEY {
    static let key: String = "01HHQA2TDGWH12D8HWFYXY6HA3"
}

struct ExerciseView: View {
    var viewModel: ExerciseViewModel
    var quickPose = QuickPose(sdkKey: API_KEY.key)
    
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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(viewModel.exercise?.name ?? "no name")
                Text(viewModel.exercise?.type?.rawValue.capitalized ?? "no type")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(viewModel.exercise?.description ?? "no type")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ZStack(alignment: .top) {
                    QuickPoseCameraView(useFrontCamera: true, delegate: quickPose, videoGravity: .resizeAspect)
                    QuickPoseOverlayView(overlayImage: $overlayImage, contentMode: .fit)
                }
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
                .onAppear {
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
                                print("Angle: \(angle), Reps: \(repCount)")
                            }
                            
                        } else {
                            // Show error feedback
                        }
                    })
                }
                .onDisappear {
                    quickPose.stop()
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
                Spacer()
            }
        }
    }
}



//struct ExerciseView: View {
//
//    var viewModel: ExerciseViewModel
//
//
//    @State var overlayImage: UIImage?
//    @State var leftElbowPoint = CGPoint(x: 1080/2, y: 1920/2)
//    @State var leftWristPoint = CGPoint(x: 1080/2, y: 1920/2)
//    @State var leftMCP3Point = CGPoint(x: 1080/2, y: 1920/2)
//    @State var angle: CGFloat = 0.0
//
//    var body: some View {
//        VStack() {
//            Text(viewModel.exercise?.name ?? "no name")
//            Text(viewModel.exercise?.type?.rawValue.capitalized ?? "no type")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            Text(viewModel.exercise?.description ?? "no type")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
//        GeometryReader { geometry in
//            ZStack(alignment: .top) {
//                QuickPoseCameraView(useFrontCamera: true, delegate: quickPose, videoGravity: .resizeAspect)
//                QuickPoseOverlayView(overlayImage: $overlayImage, contentMode: .fit)
//            }
//            .overlay(alignment: .topLeading) {
//                Circle()
//                // elbow
//                    .position(x: leftElbowPoint.x, y: leftElbowPoint.y)
//                    .frame(width: 12, height: 12)
//                    .foregroundColor(Color.green.opacity(1.0))
//                // wrist
//                Circle()
//                    .position(x: leftWristPoint.x, y: leftWristPoint.y)
//                    .frame(width: 12, height: 12)
//                    .foregroundColor(Color.green.opacity(1.0))
//                // MCP3
//                Circle()
//                    .position(x: leftMCP3Point.x, y: leftMCP3Point.y)
//                    .frame(width: 12, height: 12)
//                    .foregroundColor(Color.green.opacity(1.0))
//
//            }
//            .overlay(alignment: .bottom) {
//                Text("Angle: \(angle)") // remove logo here, but attribution appreciated
//                    .font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
//                    .frame(maxHeight:  40 + geometry.safeAreaInsets.bottom, alignment: .center)
//                    .padding(.bottom, 10)
//            }
//            .frame(width: geometry.size.width)
//            .edgesIgnoringSafeArea(.all)
//            .onAppear {
//                quickPose.start(features: [], onFrame: { status, image, features, feedback, landmarks in
//                    overlayImage = image
//                    if case .success = status, let landmarks = landmarks {
//
//                        // left elbow
//                        let leftElbow = landmarks.landmark(forBody: .elbow(side: .left))
//                        leftElbowPoint = leftElbow.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
//
//                        // left wrist
//                        let leftWrist = landmarks.landmark(forBody: .wrist(side: .left))
//                        leftWristPoint = leftWrist.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
//
//                        // left mcp3
//                        if let leftMCP3 = landmarks.landmark(forLeftHand: .MIDDLE_FINGER_TIP) {
//                            leftMCP3Point = leftMCP3.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
//                        }
//
//                        // compute joint angle
//                        angle = 180 - (atan2(leftMCP3Point.y - leftWristPoint.y, leftMCP3Point.x - leftWristPoint.x) - atan2(leftElbowPoint.y - leftWristPoint.y, leftElbowPoint.x - leftWristPoint.x)) * 180 / .pi
//
//                        if angle < 0 {
//                            angle += 360
//                            if angle > 180 {
//                                angle = 360 - angle
//                            }
//                        }
//                        else if angle > 180 {
//                            angle = 360 - angle
//                        }
//
//                        print(angle)
//
//                        //                        if let nose = landmarks.landmark(forFace: .faceNose) {
//                        //                            print(nose.cgPoint(scaledTo: geometry.size, flippedHorizontally: false))
//                        //                            print(nose)
//                        //                        }
//                    } else {
//                        // show error feedback
//                    }
//                })
//            }.onDisappear {
//                quickPose.stop()
//            }
//        }
//        Spacer()
//    }
//}
//
