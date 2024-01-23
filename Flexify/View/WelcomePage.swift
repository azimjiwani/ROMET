//
//  WelcomePage.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI
import AVFoundation

struct WelcomePage: View {
    @State var cameraPermissionGranted = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Flexify")
                    .font(.largeTitle)
                    .padding()
                
                // Button to navigate to the next screen
                NavigationLink(destination: ExerciseListView()) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .frame(height: 40)
                        .cornerRadius(20)
                }
                .padding()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
