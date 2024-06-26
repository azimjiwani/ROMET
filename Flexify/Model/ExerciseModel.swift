//
//  ExerciseModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation

enum ExerciseType: String, Codable {
    case wristFlexion
    case wristExtension
    case ulnarDeviation
    case radialDeviation
    case pronation
    case supination
}

struct Exercise: Identifiable, Codable {
    var id = UUID()
    let uniqueId: String?
    let type: ExerciseType?
    let name: String?
    let sets: Int?
    let reps: Int?
    let hand: Bool?
    var completedSets: Int?
    var completedReps: Int?
    var maxAngle: Int?
    var painRating: Int?
    var difficultyRating: Int?
    var notes: String?
    var isCompleted: Bool?
    
    init(json: [String: Any]) {
        self.uniqueId = json["uniqueId"] as? String
        self.name = json["exerciseName"] as? String
        self.sets = json["sets"] as? Int
        self.reps = json["reps"] as? Int
        self.hand = json["hand"] as? Bool
        self.isCompleted = json["isCompleted"] as? Bool
        
        // Map exerciseName to ExerciseType
        if let exerciseName = name?.toCamelCase() {
            self.type = ExerciseType(rawValue: exerciseName)
        } else {
            self.type = nil
        }
        self.completedReps = 0
        self.completedSets = 0
        self.maxAngle = 0
        self.painRating = 0
        self.difficultyRating = 0
        self.notes = ""
    }
}

extension String {
    func toCamelCase() -> String {
        let components = self.components(separatedBy: " ")

        let camelCaseString = components.enumerated().map { index, component in
            return index == 0 ? component.lowercased() : component.capitalized
        }.joined()

        return camelCaseString
    }
}
