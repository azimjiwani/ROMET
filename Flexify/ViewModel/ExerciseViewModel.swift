//
//  ExerciseViewModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation

class ExerciseViewModel {
    var exercise: Exercise?
    
    init(exercise: Exercise? = nil) {
        self.exercise = exercise
    }
    
    func uploadExercise(){
//        NetworkManager.shared.postExercise()
        if let exercise = self.exercise {
            NetworkManager.shared.postExercise(exercise: exercise)
        }
    }
}

