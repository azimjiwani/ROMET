//
//  DashboardView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-02.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(20)
            
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 20) { // Align the ScrollView contents to the center
                    HStack {
                        CustomGaugeTileView(currVal: 5, minVal: 0, maxVal: 7, label1: "Week")
                        CustomGaugeTileView(currVal: 18, minVal: 0, maxVal: 21, label1: "Remaining", label2: "Exercises")
                    }
                    .scaledToFit()
                    
                    HStack {
                        CustomGaugeTileView(currVal: 40, minVal: 0, maxVal: 45, label1: "Flexion", exerciseName: "Wrist Flexion")
                        CustomGaugeTileView(currVal: 30.4, minVal: 0, maxVal: 45, label1: "Extension", exerciseName: "Wrist Extension")
                    }
                    .scaledToFit()
                    
                    HStack {
                        CustomGaugeTileView(currVal: 30.4, minVal: 0, maxVal: 45, label1: "Radial", label2: "Deviation", exerciseName: "Radial Deviation")
                        CustomGaugeTileView(currVal: 30.4, minVal: 0, maxVal: 45, label1: "Ulnar", label2: "Deviation", exerciseName: "Ulnar Deviation")
                    }
                    .scaledToFit()
                }
                .padding()
            }
        }
    }
}

struct CustomGaugeTileView: View {
    private var currVal: Float
    private var minVal: Float
    private var maxVal: Float
    private var label1: String
    private var label2: String?
    private var exerciseName: String?
    
    init(currVal: Float, minVal: Float, maxVal: Float, label1: String, label2: String? = nil, exerciseName: String? = nil) {
        self.currVal = currVal
        self.minVal = minVal
        self.maxVal = maxVal
        self.label1 = label1
        self.label2 = label2
        self.exerciseName = exerciseName
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
            
            CustomGaugeView(currVal: currVal, minVal: minVal, maxVal: maxVal, label1: label1, label2: label2, exerciseName: exerciseName)
        }
        .frame(height: 170)
    }
}

struct CustomGaugeView: View {
    
    private var currVal: Float
    private var minVal: Float
    private var maxVal: Float
    private var label1: String
    private var label2: String?
    private var exerciseName: String?
    
    init(currVal: Float, minVal: Float, maxVal: Float, label1: String, label2: String? = nil, exerciseName: String? = nil) {
        self.currVal = currVal
        self.minVal = minVal
        self.maxVal = maxVal
        self.label1 = label1
        self.label2 = label2
        self.exerciseName = exerciseName
    }
    
    var body: some View {
        Gauge(value: currVal, in: minVal...maxVal) {
            Image(systemName: "gauge.medium")
                .font(.system(size: 50.0))
        } currentValueLabel: {
            HStack(alignment: .bottom, spacing: 0) {
                
                if exerciseName != nil {
                    Text("\(currVal.formatted(.number))")
                        .font(.system(size: 32), .lineHeight)
                    Text("/\(maxVal.formatted(.number))°")
                        .font(.system(size: 16))
                    
                } else {
                    Text("\(currVal.formatted(.number))")
                        .font(.system(size: 32))
                    Text("/\(maxVal.formatted(.number))")
                        .font(.system(size: 16))
                }
            }
        }
        .gaugeStyle(SpeedometerGaugeStyle(label1: label1, label2: label2, maxVal: maxVal, exerciseName: exerciseName))
    }
}

struct SpeedometerGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255) ]), startPoint: .trailing, endPoint: .leading)
    
    private var label1: String
    private var label2: String?
    private var maxVal: CGFloat
    private var exerciseName: String?
    
    init(label1: String, label2: String? = nil, maxVal: Float, exerciseName: String? = nil) {
        self.label1 = label1
        self.label2 = label2
        self.maxVal = CGFloat(maxVal)
        self.exerciseName = exerciseName
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(.systemGray6))
            
            Circle()
                .trim(from: 0, to: 0.75 * maxVal)
                .stroke(.gray, lineWidth: 20)
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(purpleGradient, lineWidth: 20)
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: 0.75, to: 1)
                .stroke(.black, lineWidth: 20)
                .rotationEffect(.degrees(135))
            
            //            Circle()
            //                .trim(from: 0, to: 0.75)
            //                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .round, dash: [1, 100], dashPhase: 0.0))
            //                .rotationEffect(.degrees(135))
            
            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundColor(.gray)
                Text(label1)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.gray)
                if let label2 = label2 {
                    Text(label2)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.gray)
                }
            }
            
        }
        .frame(height: 150)
    }
}
