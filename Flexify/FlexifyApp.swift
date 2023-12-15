//
//  FlexifyApp.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI
import AVFoundation

@main
struct FlexifyApp: App {
    var body: some Scene {
        WindowGroup {
            DemoAppView()
        }
    }
}

struct DemoAppView: View {
    @State var cameraPermissionGranted = false
    var body: some View {
        GeometryReader { geometry in
            if cameraPermissionGranted {
                ContentView()
            }
        }.onAppear {
            AVCaptureDevice.requestAccess(for: .video) { accessGranted in
                DispatchQueue.main.async {
                    self.cameraPermissionGranted = accessGranted
                }
            }
        }
    }
}
