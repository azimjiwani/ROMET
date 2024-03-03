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
        TabView {
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
            .tabItem {
                Label("Exercises", systemImage: "calendar")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .onAppear {
                viewModel.getExercises()
            }
            
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.line.uptrend.xyaxis")
                }
            
        }
        .navigationBarHidden(true)
    }
}
