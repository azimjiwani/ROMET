//
//  ContentView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct ContentView: View {
    private var quickPose = QuickPose(sdkKey: "01HHQA2TDGWH12D8HWFYXY6HA3") // register for your free key at https://dev.quickpose.ai
    @State private var overlayImage: UIImage?
    @State private var leftElbowPoint = CGPoint(x: 1080/2, y: 1920/2)
    @State private var leftWristPoint = CGPoint(x: 1080/2, y: 1920/2)
    @State private var leftMCP3Point = CGPoint(x: 1080/2, y: 1920/2)
    @State private var angle: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                QuickPoseCameraView(useFrontCamera: true, delegate: quickPose, videoGravity: .resizeAspect)
                QuickPoseOverlayView(overlayImage: $overlayImage, contentMode: .fit)
            }
            .overlay(alignment: .topLeading) {
                Circle()
                // elbow
                    .position(x: leftElbowPoint.x, y: leftElbowPoint.y)
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.green.opacity(1.0))
                // wrist
                Circle()
                    .position(x: leftWristPoint.x, y: leftWristPoint.y)
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.green.opacity(1.0))
                // MCP3
                Circle()
                    .position(x: leftMCP3Point.x, y: leftMCP3Point.y)
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.green.opacity(1.0))
                
            }
            .overlay(alignment: .bottom) {
                Text("Angle: \(angle)") // remove logo here, but attribution appreciated
                    .font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                    .frame(maxHeight:  40 + geometry.safeAreaInsets.bottom, alignment: .center)
                    .padding(.bottom, 10)
            }
            .frame(width: geometry.size.width)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                quickPose.start(features: [], onFrame: { status, image, features, feedback, landmarks in
                    overlayImage = image
                    if case .success = status, let landmarks = landmarks {
                        
                        // left elbow
                        let leftElbow = landmarks.landmark(forBody: .elbow(side: .left))
                        leftElbowPoint = leftElbow.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
                        
                        // left wrist
                        let leftWrist = landmarks.landmark(forBody: .wrist(side: .left))
                        leftWristPoint = leftWrist.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
                        
                        // left mcp3
                        if let leftMCP3 = landmarks.landmark(forLeftHand: .MIDDLE_FINGER_TIP) {
                            leftMCP3Point = leftMCP3.cgPoint(scaledTo: geometry.size, flippedHorizontally: true)
                        }
                        
                        // compute joint angle
                        angle = 180 - (atan2(leftMCP3Point.y - leftWristPoint.y, leftMCP3Point.x - leftWristPoint.x) - atan2(leftElbowPoint.y - leftWristPoint.y, leftElbowPoint.x - leftWristPoint.x)) * 180 / .pi
                        
                        if angle < 0 {
                            angle += 360
                            if angle > 180 {
                                angle = 360 - angle
                            }
                        }
                        else if angle > 180 {
                            angle = 360 - angle
                        }
                                    
                        print(angle)
                        
//                        if let nose = landmarks.landmark(forFace: .faceNose) {
//                            print(nose.cgPoint(scaledTo: geometry.size, flippedHorizontally: false))
//                            print(nose)
//                        }
                    } else {
                        // show error feedback
                    }
                })
            }.onDisappear {
                quickPose.stop()
            }
        }
    }
}
