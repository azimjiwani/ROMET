//
//  ExerciseSummaryView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-01-30.
//

import SwiftUI

struct ExerciseSummaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var nameIsFocused: Bool
        
    var viewModel: ExerciseViewModel
    @State private var painRating: Double = 0.0
    @State private var difficultyRating: Double = 0.0
    
    let placeholderString: String = "Write any notes here"
    @State private var notesText: String = ""
    
    func setPlaceholderText() {
        notesText = placeholderString
    }
    
    var body: some View {
        ZStack {
            Colours.backgroundColour.ignoresSafeArea()
            VStack(alignment: .leading) { // Align VStack to leading edge
                Text("Summary")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundStyle(Colours.primaryTextColour)
                
                if let name = viewModel.exercise?.name {
                    Text("\(name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(Colours.secondaryTextColour)
                }
                
                ScrollView(.vertical) {
                    HStack {
                        if let sets = viewModel.exercise?.sets, let completedSets = viewModel.exercise?.completedSets, let reps = viewModel.exercise?.reps, let completedReps = viewModel.exercise?.completedReps {
                            VStack(alignment: .leading) {
                                Text("Sets")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Colours.buttonBackgroundColour)
                                Text("\(completedSets) / \(sets)")
                                    .foregroundStyle(Colours.primaryTextColour)
                            }
                            .padding(.vertical, 10)
                            .padding(.leading, 15)
                            
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Reps")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Colours.buttonBackgroundColour)
                                Text("\(completedReps) / \(sets*reps)")
                                    .foregroundStyle(Colours.primaryTextColour)
                            }
                            .padding(.vertical, 10)
                        }
                        
                        Spacer()
                        if let maxAngle = viewModel.exercise?.maxAngle {
                            VStack(alignment: .leading) {
                                Text("Max Angle")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Colours.buttonBackgroundColour)
                                Text("\(maxAngle)°")
                                    .foregroundStyle(Colours.primaryTextColour)
                            }
                            .padding(.vertical, 10)
                            .padding(.trailing, 15)
                        }
                    }
                    .background(Colours.listBackgroundColour)
                    .cornerRadius(15)
                    .padding(.horizontal, 15)
                    
                    // rate pain
                    RatingView(title: "Pain", rating: $painRating) { newValue in
                        viewModel.exercise?.painRating = Int(newValue.rounded())
                    }
                    
                    
                    RatingView(title: "Difficulty", rating: $difficultyRating) { newValue in
                        viewModel.exercise?.difficultyRating = Int(newValue.rounded())
                    }
                    
                    // notes
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Colours.secondaryTextColour)
                            .padding(.top, 15)
                            .padding(.leading, 15)
                        
                        TextEditor(text: $notesText)
                            .foregroundColor(self.notesText == placeholderString ? .gray : .black)
                            .focused($nameIsFocused)
                            .onTapGesture {
                                if self.notesText == placeholderString {
                                    self.notesText = ""
                                }
                            }
                            .toolbar {
                                // Add a toolbar with a "Done" button to dismiss the keyboard
                                ToolbarItem(placement: .keyboard) {
                                    Button("Done") {
                                        UIApplication.shared.endEditing()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .padding(.horizontal, 15)
                    }.onAppear {
                        setPlaceholderText()
                    }
                    .background(Colours.listBackgroundColour)
                    .frame(height: 200)
                    .cornerRadius(15)
                    .padding(.horizontal, 15)
                    
                    Spacer()
                    
                    // Button to navigate back to the main screen
                    Button("Finish") {
                        viewModel.exercise?.notes = notesText
                        viewModel.uploadExercise()
                        presentationMode.wrappedValue.dismiss()
                        presentationMode.wrappedValue.dismiss()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                    .foregroundStyle(Colours.buttonTextColour)
                    .padding()
                    .background(Colours.buttonBackgroundColour)
                    .frame(height: 40)
                    .cornerRadius(20)
                    .clipShape(Capsule())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
