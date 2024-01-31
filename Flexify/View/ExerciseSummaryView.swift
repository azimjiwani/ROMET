//
//  ExerciseSummaryView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-01-30.
//

import SwiftUI

struct ExerciseSummaryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var viewModel: ExerciseViewModel
    
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
            
            
            HStack(spacing: 20) {
                if let sets = viewModel.exercise?.sets, let completedSets = viewModel.exercise?.completedSets {
                    VStack(alignment: .leading) {
                        Text("Sets")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                        Text("\(completedSets) / \(sets)")
                    }
                }
                
                if let reps = viewModel.exercise?.reps, let completedReps = viewModel.exercise?.completedReps {
                    VStack(alignment: .leading) {
                        Text("Reps")
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                        Text("\(completedReps) / \(reps)")
                    }
                }
                
                if let maxAngle = viewModel.exercise?.maxAngle {
                    VStack(alignment: .leading) {
                        Text("Max Angle")
                            .fontWeight(.bold)
                            .foregroundStyle(.cyan)
                        Text("\(maxAngle)")
                    }
                }
            }
            .padding(20)
            
            Spacer()
            
            
            
            // Button to navigate back to the main screen
            Button("Go to Main Screen") {
                presentationMode.wrappedValue.dismiss() // Dismiss current view
            }
            .padding() // Add padding to the button
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
    }
}

// rank difficulty
// rank pain

// notes
