//
//  DashboardViewModel.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-18.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var dashboardData: UserDashboard?

    func getDashboardData() {
        NetworkManager.shared.fetchDashboardData() { dashboardData in
            self.dashboardData = dashboardData
        }
    }
}
