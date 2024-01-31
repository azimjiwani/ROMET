//
//  ExerciseListView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var viewModel = ExerciseListViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercises")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(20)
            
            List {
                ForEach(viewModel.exerciseList, id: \.id) { exercise in
                    let exerciseViewModel = ExerciseViewModel(exercise: exercise)
                    let exerciseView = ExerciseView(viewModel: exerciseViewModel)
                    
                    NavigationLink(destination: exerciseView) {
                        VStack(alignment: .leading) {
                            Text(exercise.name ?? "no name")
                            Text(exercise.type?.rawValue.capitalized ?? "no type")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .onAppear {
            viewModel.getExercises()
        }
        .navigationBarHidden(true)
    }
}
