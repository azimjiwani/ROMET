//
//  CustomSlider.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-02-05.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var rating: Double
    var onValueChanged: (Double) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                HStack(spacing: (UIScreen.main.bounds.width - 160) / 55) { // Adjusted spacing to account for padding
                    ForEach(0...50, id: \.self) { index in
                        Rectangle()
                            .fill(index % 5 == 0 ? Color.black.opacity(0.55) : Color.black.opacity(0.3))
                            .frame(width: 2, height: index % 5  == 0 ? 20 : 12)
                    }
                }
                
                SliderView(value: $rating, onValueChanged: onValueChanged)
                    .padding(.horizontal, 10)
                    .frame(height: 35)
            }
        }
    }
}
