//
//  UserModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-15.
//

import Foundation

struct UserDashboard: Codable {
    let currentWeek: Int?
    let injuryTime: Int?
    let exercisesCompleted: Int?
    let totalExercises: Int?
    let maxWristFlexion: Int?
    let targetWristFlexion: Int?
    let maxWristExtension: Int?
    let targetWristExtension: Int?
    let maxUlnarDeviation: Int?
    let targetUlnarDeviation: Int?
    let maxRadialDeviation: Int?
    let targetRadialDeviation: Int?
    
    init(json: [String: Any]) {
        self.currentWeek = json["currentWeek"] as? Int
        self.injuryTime = json["injuryTime"] as? Int
        self.exercisesCompleted = json["exercisesCompleted"] as? Int
        self.totalExercises = json["totalExercises"] as? Int
        self.maxWristFlexion = json["maxWristFlexion"] as? Int
        self.targetWristFlexion = json["targetWristFlexion"] as? Int
        self.maxWristExtension = json["maxWristExtension"] as? Int
        self.targetWristExtension = json["targetWristExtension"] as? Int
        self.maxUlnarDeviation = json["maxUlnarDeviation"] as? Int
        self.targetUlnarDeviation = json["targetUlnarDeviation"] as? Int
        self.maxRadialDeviation = json["maxRadialDeviation"] as? Int
        self.targetRadialDeviation = json["targetRadialDeviation"] as? Int
    }
}

struct UserProfile: Codable {
    let username: String?
    let firstName: String?
    let lastName: String?
    let injuredHand: String?
    let injuryType: String?
    let rehabStartDate: String?
    let rehabEndDate: String?
    let goals: [String]?
        
    init(json: [String: Any]) {
        self.username = json["userName"] as? String
        self.firstName = json["firstName"] as? String
        self.lastName = json["lastName"] as? String
        self.injuredHand = json["injuredHand"] as? String
        self.injuryType = json["injuryType"] as? String
        self.rehabStartDate = json["rehabStart"] as? String
        self.rehabEndDate = "None"
        self.goals = ["goal 1", "goal 2", "goal 3"]
    }
}
