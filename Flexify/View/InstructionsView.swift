//
//  InstructionsView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-06.
//

import SwiftUI

struct InstructionsView: View {
    var viewModel: ExerciseViewModel
    @Binding var goBackToRoot: Bool
    
    var body: some View {
        ZStack {
            Colours.backgroundColour.ignoresSafeArea()
            VStack(alignment: .leading){
                Text(viewModel.exercise?.name ?? "NULL")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundStyle(Colours.primaryTextColour)
                Spacer()
                NavigationLink(destination: ExerciseView(viewModel: viewModel, goBackToRoot: self.$goBackToRoot).toolbar(.hidden, for: .tabBar)) {
                    Text("Proceed To Exercise")
                        .font(.headline)
                        .foregroundStyle(Colours.buttonTextColour)
                        .padding()
                        .background(Colours.buttonBackgroundColour)
                        .frame(height: 40)
                        .cornerRadius(20)
                }
                Spacer()
            }
        }
    }
}
