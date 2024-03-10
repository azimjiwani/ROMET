//
//  ProfileView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-07.
//

import SwiftUI

struct ProfileView: View {
    
    let goals = ["Workout", "Drink more water", "Read a book"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)
                Spacer()
            }
            
            // name
            HStack {
                VStack(alignment: .leading) {
                    Text("First Name")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("BIPIN")
                        .font(.headline)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("KUMAR")
                        .font(.headline)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // username
            HStack {
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("bipinkumar")
                        .font(.headline)
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
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Left")
                        .font(.headline)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Injury Type")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("DRF")
                        .font(.headline)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // Dates
            HStack {
                VStack(alignment: .leading) {
                    Text("Rehab Start Date")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Today")
                        .font(.headline)
                }
                .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Rehab End date")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Tomorrow")
                        .font(.headline)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // Goals
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Goals")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    ForEach(0..<goals.count, id: \.self) { index in
                        Text("\(index + 1). \(goals[index])")
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            Spacer()
        }
    }
}
