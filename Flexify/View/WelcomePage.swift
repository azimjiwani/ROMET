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
    private func validateUsername() {
        
        // Construct URL with username as a query parameter
        guard let url = URL(string: "\(Constants.backendURL)/verify-username/?userName=\(username)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let isValid = try? JSONDecoder().decode(Bool.self, from: data) {
                DispatchQueue.main.async {
                    isUsernameValid = isValid
                    if isValid {
                        User.shared.username = username
                        shouldNavigate = true // Set shouldNavigate to true only if the username is valid
                    }
                }
            } else {
                print("Failed to decode response")
                isUsernameValid = false
            }
            
        }.resume()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Colours.backgroundColour
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Welcome to ROMET")
                        .font(.largeTitle)
                        .foregroundStyle(Colours.primaryTextColour)
                        .padding()
                    
                    TextField("", text: $username, prompt: Text("Enter username").foregroundStyle(Colours.primaryTextColour))
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
                        validateUsername()
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
                    
                    // Use NavigationLink with tag and selection to programmatically navigate
                    NavigationLink(destination: ExerciseListView(), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
        }.toolbar(.hidden, for: .navigationBar)
    }
}
