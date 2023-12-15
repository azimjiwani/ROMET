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
    @State var cameraPermissionGranted = true
    var body: some Scene {
        WindowGroup {
            WelcomePage()
        }
    }
}

struct DemoAppView: View {
    @State var cameraPermissionGranted = true
    var body: some View {
        GeometryReader { geometry in
            if cameraPermissionGranted {
                WelcomePage()
            }
        }
    }
}
