//
//  SliderView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-02-05.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    var onValueChanged: (Double) -> Void
    var sliderRange: ClosedRange<Double> = 0...10
    var thumbColor: Color = .blue
    var minTrackColor: Color = .clear
    var maxTrackColor: Color = .clear

    var body: some View {
        GeometryReader { gr in
            let thumbHeight = gr.size.height * 1.1
            let thumbWidth = gr.size.width * 0.02
            let minValue = self.sliderRange.lowerBound
            let maxValue = self.sliderRange.upperBound
            
            let sliderWidth = gr.size.width - thumbWidth // Adjusted width for the thumb
            
            let scaleFactor = sliderWidth / (maxValue - minValue)
            let sliderVal = CGFloat((self.value - minValue) * scaleFactor)
            
            ZStack {
                Rectangle()
                    .foregroundColor(self.maxTrackColor)
                    .frame(width: gr.size.width, height: gr.size.height * 0.95)
                HStack {
                    Rectangle()
                        .foregroundColor(self.minTrackColor)
                        .frame(width: sliderVal, height: gr.size.height * 0.95)
                    Spacer()
                }
                
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Colours.secondaryTextColour)
                            .frame(width: thumbWidth, height: thumbHeight)
                            .offset(x: min(max(sliderVal, 0), gr.size.width - thumbWidth)) // Ensure thumb stays within track bounds
                        
                        Rectangle()
                            .frame(width: 20, height: thumbHeight)
                            .opacity(0.001)
                            .offset(x: min(max(sliderVal, 0), gr.size.width - thumbWidth)) // Ensure thumb stays within track bounds
                            .layoutPriority(-1)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { v in
                                        let offset = v.location.x
                                        let newValue = Double(min(max(0.0, Double(offset / scaleFactor) + minValue), maxValue))
                                        self.value = newValue
                                        self.onValueChanged(self.value)
                                    }
                            )
                    }
                    Spacer()
                }
            }
        }
    }
}
