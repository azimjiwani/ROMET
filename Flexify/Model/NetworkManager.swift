//
//  NetworkManager.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation

class NetworkManager {
    class func fetchExercises(completionHandler: @escaping([Exercise]) -> Void) {
        let exerciseNames = ["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4", "Exercise 5"]
        let exercises = exerciseNames.map { Exercise(type: nil, name: $0, description: "\($0) description", sets: nil, reps: nil) }
        completionHandler(exercises)
    }
}
