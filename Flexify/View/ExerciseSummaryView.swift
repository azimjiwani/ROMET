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
        VStack(alignment: .leading) { // Align VStack to leading edge
            Text("Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(20)
            
            if let name = viewModel.exercise?.name {
                Text("\(name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            
            ScrollView(.vertical) {
                HStack {
                    if let sets = viewModel.exercise?.sets, let completedSets = viewModel.exercise?.completedSets, let reps = viewModel.exercise?.reps, let completedReps = viewModel.exercise?.completedReps {
                        VStack(alignment: .leading) {
                            Text("Sets")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                            Text("\(completedSets) / \(sets)")
                                .foregroundStyle(.black)
                        }
                        .padding(.vertical, 10)
                        .padding(.leading, 15)
                        
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Reps")
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                            Text("\(completedReps) / \(sets*reps)")
                                .foregroundStyle(.black)
                        }
                        .padding(.vertical, 10)
                    }
                    
                    Spacer()
                    if let maxAngle = viewModel.exercise?.maxAngle {
                        VStack(alignment: .leading) {
                            Text("Max Angle")
                                .fontWeight(.bold)
                                .foregroundStyle(.cyan)
                            Text("\(maxAngle)")
                                .foregroundStyle(.black)
                        }
                        .padding(.vertical, 10)
                        .padding(.trailing, 15)
                    }
                }
                .background(.white)
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
                        .foregroundStyle(.black)
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
                .background(.white)
                .frame(height: 200)
                .cornerRadius(15)
                .padding(.horizontal, 15)
                
                Spacer()
                
                // Button to navigate back to the main screen
                Button("Finish") {
                    viewModel.exercise?.notes = notesText
                    viewModel.uploadExercise()
                    presentationMode.wrappedValue.dismiss() // Dismiss current view
                    presentationMode.wrappedValue.dismiss()
                }
                .padding() // Add padding to the button
                .background(.blue)
                .font(.headline)
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
