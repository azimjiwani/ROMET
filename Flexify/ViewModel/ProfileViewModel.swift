//
//  ProfileViewModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-18.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profileData: UserProfile?

    func getProfileData() {
        NetworkManager.shared.fetchProfileData() { profileData in
            self.profileData = profileData
        }
    }
}
