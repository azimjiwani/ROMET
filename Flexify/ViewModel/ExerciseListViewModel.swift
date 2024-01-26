//
//  ExerciseListViewModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation
import SwiftUI

class ExerciseListViewModel: ObservableObject {
    @Published var exerciseList = [Exercise]()

    func getExercises() {
        NetworkManager.shared.fetchExercises() { exercises in
            if let exercises = exercises {
                self.exerciseList = exercises
            }
        }
    }
}
