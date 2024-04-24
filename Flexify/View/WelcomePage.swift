//
//  WelcomePage.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI

struct WelcomePage: View {
    @State var cameraPermissionGranted = false
    @State private var username = ""
    @State private var isUsernameValid = true // Set initial value to true
    @State private var shouldNavigate = false // New state variable for navigation
    
    // Function to validate the username
    func validateUsername(username: String) {
        NetworkManager.shared.validateUsername(username: username) { isValid in
            if isValid {
                User.shared.username = username
                shouldNavigate = true
            }
        }
    }

    
    var body: some View {
        NavigationView {
            ZStack {
                Colours.backgroundColour
                    .ignoresSafeArea()
                
                VStack {
                    Spacer(minLength: 40)
                    
                    Image(.logo)
                        .resizable()
                        .frame(width: 250, height: 250)
                                        
                    Text("Welcome to ROMET")
                        .font(.largeTitle)
                        .foregroundStyle(Colours.primaryTextColour)
                        .padding()
                    
                    TextField("", text: $username, prompt: Text("Enter username").foregroundStyle(Colours.primaryTextColour))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Colours.primaryTextColour)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Colours.buttonTextColour, lineWidth: 2)
                        }
                        .frame(width: 300)
                        .padding(.horizontal)
                    
                    if !isUsernameValid {
                        Text("Invalid username")
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }
                    
                    Spacer()
                    
                    Button {
                        validateUsername(username: username)
                    } label: {
                        Text("Login")
                            .font(.headline)
                            .foregroundStyle(Colours.buttonTextColour)
                            .bold()
                    }
                    .frame(width: 200, height: 50)
                    .background(Colours.buttonBackgroundColour)
                    .cornerRadius(25)
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    NavigationLink(destination: ExerciseListView(), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
        }
        .background(Colours.backgroundColour)
        .toolbar(.hidden, for: .navigationBar)
    }
}
