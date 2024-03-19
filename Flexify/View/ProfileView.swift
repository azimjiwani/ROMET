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
                    
                    Text(viewModel.profileData?.firstName ?? "None")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.lastName ?? "None")
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
                    
                    Text(viewModel.profileData?.username ?? "None")
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
                    
                    Text(viewModel.profileData?.injuredHand ?? "None")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Injury Type")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.injuryType ?? "None")
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
                    
                    Text(viewModel.profileData?.rehabStartDate ?? "None")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Colours.primaryTextColour)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Rehab End date")
                        .font(.body)
                        .foregroundColor(Colours.secondaryTextColour)
                    
                    Text(viewModel.profileData?.rehabEndDate ?? "None")
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
                    
                    if let goals = viewModel.profileData?.goals {
                        
                        ForEach(0..<(goals.count), id: \.self) { index in
                            Text("\(index + 1). \(goals[index])")
                                .foregroundStyle(Colours.primaryTextColour)
                        }
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
