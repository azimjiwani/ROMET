//
//  UserModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-15.
//

import Foundation

struct UserModel: Codable {
    let username: String?
    let firstName: String?
    let lastName: String?
    let injuredHand: String?
    let injuryType: String?
    let rehabStartDate: String?
    let rehabDuration: Int?
    let rehabEndDate: String?
    let goals: [String]?
        
    init(json: [String: Any]) {
        self.username = json["userName"] as? String
        self.firstName = json["firstName"] as? String
        self.lastName = json["lastName"] as? String
        self.injuredHand = json["injuredHand"] as? String
        self.injuryType = json["injuryType"] as? String
        self.rehabStartDate = json["rehabStart"] as? String
        self.rehabDuration = json["rehabDuration"] as? Int
        self.rehabEndDate = json["rehabEnd"] as? String
        self.goals = json["goals"] as? [String]
    }
}
