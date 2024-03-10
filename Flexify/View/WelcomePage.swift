//
//  WelcomePage.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI

struct WelcomePage: View {
    @State var cameraPermissionGranted = false
    var body: some View {
        NavigationView {
            ZStack {
                Colours.backgroundColour
                    .ignoresSafeArea()
                
                VStack {
                    Text("Welcome to ROMET")
                        .font(.largeTitle)
                        .foregroundStyle(Colours.primaryTextColour)
                        .padding()
                    
                    // Button to navigate to the next screen
                    NavigationLink(destination: ExerciseListView().toolbar(.visible, for: .tabBar)) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundStyle(Colours.buttonTextColour)
                            .padding()
                            .background(Colours.buttonBackgroundColour)
                            .frame(height: 40)
                            .cornerRadius(20)
                    }
                    .padding()
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

