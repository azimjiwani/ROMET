//
//  ExerciseModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2023-12-15.
//

import Foundation

enum ExerciseType: String {
    case wristFlexion
    case wristExtension
    case ulnarDeviation
    case radialDeviation
    case pronation
    case supination
}

struct Exercise: Identifiable {
    var id = UUID()
    let type: ExerciseType?
    let name: String?
    let description: String?
    let sets: Int?
    let reps: Int?
}
