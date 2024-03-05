//
//  ExerciseListView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var viewModel = ExerciseListViewModel()
    @State private var currentDate = Date()
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    Text("Exercises")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(20)
                    Spacer()
                }
                
                
                HStack {
                    Button(action: {
                        self.currentDate = Calendar.current.date(byAdding: .day, value: -1, to: self.currentDate) ?? self.currentDate
                        // Update items in the list based on new date
//                        self.updateItems()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                    }
                    
                    Text("\(formattedDate(date: currentDate))")
                        .font(.title)
                        .padding()
                    
                    Button(action: {
                        self.currentDate = Calendar.current.date(byAdding: .day, value: 1, to: self.currentDate) ?? self.currentDate
                        // Update items in the list based on new date
//                        self.updateItems()
                    }) {
                        Image(systemName: "chevron.right")
                            .padding()
                    }
                }
                
                List {
                    ForEach(viewModel.exerciseList, id: \.id) { exercise in
                        let exerciseViewModel = ExerciseViewModel(exercise: exercise)
                        let exerciseView = ExerciseView(viewModel: exerciseViewModel)
                        
                        NavigationLink(destination: exerciseView) {
                            VStack(alignment: .leading) {
                                Text(exercise.name ?? "no name")
                                HStack {
                                    Text(exercise.type?.rawValue.capitalized ?? "no type")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text(exercise.hand == true ? "left" : "right" )
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                }
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
