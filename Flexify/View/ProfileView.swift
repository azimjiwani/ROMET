//
//  ProfileView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-07.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                    .foregroundStyle(Colours.primaryTextColour)
                Spacer()
            }
            
            // name
            HStack {
                VStack(alignment: .leading) {
                    Text("First Name")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.firstName ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.lastName ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // username
            HStack {
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.username ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // injury
            HStack {
                VStack(alignment: .leading) {
                    Text("Injured Hand")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.injuredHand ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Injury Type")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.injuryType ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // Dates
            HStack {
                VStack(alignment: .leading) {
                    Text("Rehab Start Date")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.rehabStartDate ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Rehab End date")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.rehabEndDate ?? "NULL")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // Goals
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Goals")
                        .font(.title3)
                        .padding(.top, 20)
                        .bold()
                        .foregroundStyle(Colours.secondaryTextColour)
                    
                    if let goal1 = viewModel.profileData?.goal1 {
                        Text("1. \(goal1)")
                    }
                    
                    if let goal2 = viewModel.profileData?.goal2 {
                        Text("2. \(goal2)")
                    }
                    
                    if let goal3 = viewModel.profileData?.goal3 {
                        Text("3. \(goal3)")
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Spacer()
        }
        .onAppear {
            viewModel.getProfileData()
        }
    }
}
