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
                        .foregroundStyle(Colours.primaryTextColour)
                        .padding(20)
                    Spacer()
                }
                HStack {
                    Button(action: {
                        self.currentDate = Calendar.current.date(byAdding: .day, value: -1, to: self.currentDate) ?? self.currentDate
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                    }
                    
                    Text("\(formattedDate(date: currentDate))")
                        .font(.title)
                        .foregroundStyle(Colours.secondaryTextColour)
                        .padding()
                    
                    Button(action: {
                        self.currentDate = Calendar.current.date(byAdding: .day, value: 1, to: self.currentDate) ?? self.currentDate
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
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Colours.backgroundColour) // Set background color for list
                
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(12)
            .onAppear {
                viewModel.getExercises()
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
