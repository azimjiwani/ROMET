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
            VStack(alignment: .center){
                Text(viewModel.exercise?.name ?? "NULL")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundStyle(Colours.primaryTextColour)
                
                //TODO:
                //Make instructions for all four exercises respectively
                //Check the connection between the ExerciseListView and InstructionsView to ensure consistency
                //Make wrapper for gifs
                
                // Insert images here
                Image("Instructions/flex_neutral")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Wrist positioned at neutral starting point")
                .font(.caption)
                .foregroundColor(.gray)
                
                Image("Instructions/flex_down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Wrist move down and hold at max angle for one second")
                .font(.caption)
                .foregroundColor(.gray)
                
                Image("Instructions/flex_up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Wrist move up and return to neutral position")
                .font(.caption)
                .foregroundColor(.gray)

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
