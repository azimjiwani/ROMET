//
//  ExerciseListView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var viewModel = ExerciseListViewModel()
    @State private var date = Date()
    
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func formatDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    Text("Exercises")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Colours.primaryTextColour)
                        .padding(20)
                    Spacer()
                }
                HStack {
                    Button(action: {
                        self.date = Calendar.current.date(byAdding: .day, value: -1, to: self.date) ?? self.date
                        viewModel.getExercises(date: formatDateToString(date: self.date))
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                    }
                    
                    Text("\(formattedDate(date: date))")
                        .font(.title)
                        .foregroundStyle(Colours.secondaryTextColour)
                        .padding()
                    
                    Button(action: {
                        self.date = Calendar.current.date(byAdding: .day, value: 1, to: self.date) ?? self.date
                        viewModel.getExercises(date: formatDateToString(date: self.date))
                    }) {
                        Image(systemName: "chevron.right")
                            .padding()
                    }
                }
                
                List {
                    ForEach(0 ..< viewModel.exerciseList.count, id: \.self) { index in
                        if index % 4 == 0 {
                            Section(header: Text("Session \(index / 4 + 1)")
                                .foregroundStyle(Colours.buttonBackgroundColour)
                                .fontWeight(.bold)
                            ) {
                                ForEach(index ..< min(index + 4, viewModel.exerciseList.count), id: \.self) { innerIndex in
                                    let exercise = viewModel.exerciseList[innerIndex]
                                    let exerciseViewModel = ExerciseViewModel(exercise: exercise)
                                    let instructionView = InstructionsView(viewModel: exerciseViewModel)
                                    
                                    // Check if the exercise is not completed before making the row tappable
                                    if exercise.isCompleted == false {
                                        NavigationLink(destination: instructionView.toolbar(.hidden, for: .tabBar)) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(exercise.name ?? "no name")
                                                        .foregroundStyle(Colours.primaryTextColour)
                                                    
                                                    Text(exercise.hand == true ? "left" : "right" )
                                                        .font(.subheadline)
                                                        .foregroundStyle(Colours.secondaryTextColour)
                                                }
                                                Spacer()
                                            }
                                        }
                                        .listRowBackground(Colours.listBackgroundColour)
                                    } else {
                                        // Display non-tappable row for completed exercises
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(exercise.name ?? "no name")
                                                    .foregroundStyle(Colours.primaryTextColour)
                                                
                                                Text(exercise.hand == true ? "left" : "right" )
                                                    .font(.subheadline)
                                                    .foregroundStyle(Colours.secondaryTextColour)
                                            }
                                            Spacer()
                                            Image(systemName: "checkmark.circle")
                                                .foregroundStyle(Colours.primaryTextColour)
                                                .padding()
                                        }
                                        .listRowBackground(Colours.listBackgroundColour)
                                    }
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Colours.backgroundColour)

                
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(12)
            .onAppear {
                viewModel.getExercises(date: formatDateToString(date: self.date))
            }
            
            .tabItem {
                Label("Exercises", systemImage: "calendar")
            }
            .background(Colours.backgroundColour) // Setting background color for TabView
            .navigationBarHidden(true)
            .background(Colours.backgroundColour)
            
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.line.uptrend.xyaxis")
                }
                .background(Colours.backgroundColour) // Setting background color for TabView
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .background(Colours.backgroundColour) // Setting background color for TabView
        }
    }
}
