//
//  InstructionsView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-06.
//

import SwiftUI

struct InstructionsView: View {
    var viewModel: ExerciseViewModel
    
    var body: some View {
        VStack {
            Text("Instructions for")
            Text(viewModel.exercise?.name ?? "no name")
            Spacer()
            NavigationLink(destination: ExerciseView(viewModel: viewModel)) {
                Text("Proceed To Exercise")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .frame(height: 40)
                    .cornerRadius(20)
            }
            Spacer()
        }
    }
}
