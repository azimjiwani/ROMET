//
//  RatePainView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-02-05.
//

import SwiftUI

struct RatingView: View {
    
    var title: String
    @Binding var rating: Double
    var onValueChanged: (Double) -> Void
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(.leading, 15)
                    .foregroundStyle(Colours.primaryTextColour)
                Spacer()
                Text("\(rating, specifier: "%.0f")")
                    .padding(.trailing, 15)
                    .foregroundStyle(Colours.primaryTextColour)
            }
            
            CustomSlider(rating: $rating, onValueChanged: { newValue in
                onValueChanged(newValue)
            })
        }
        .frame(height: 100)
        .background(Colours.listBackgroundColour)
        .cornerRadius(15)
        .padding(.horizontal, 15)
    }
}
