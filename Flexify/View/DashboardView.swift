//
//  DashboardView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-02.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = DashboardViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Dashboard")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Colours.primaryTextColour)
                    .padding(20)
                Spacer()
            }
            
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 10) { // Align the ScrollView contents to the center
                    
                    if let currentWeek = viewModel.dashboardData?.currentWeek, let injuryTime = viewModel.dashboardData?.injuryTime, let completedExercises = viewModel.dashboardData?.exercisesCompleted, let totalExercises = viewModel.dashboardData?.totalExercises {
                        HStack {
                            CustomGaugeTileView(currVal: Float(currentWeek), minVal: 0, maxVal: Float(injuryTime), label1: "Week")
                            CustomGaugeTileView(currVal: Float(completedExercises), minVal: 0, maxVal: Float(totalExercises), label1: "Exercises", label2: "Completed")
                        }
                        .scaledToFit()
                    }
                    
                    if let maxWristFlexion = viewModel.dashboardData?.maxWristFlexion, let targetWristFlexion = viewModel.dashboardData?.targetWristFlexion, let maxWristExtension = viewModel.dashboardData?.maxWristExtension, let targetWristExtension = viewModel.dashboardData?.targetWristExtension {
                        HStack {
                            CustomGaugeTileView(currVal: Float(maxWristFlexion), minVal: 0, maxVal: Float(targetWristFlexion), label1: "Wrist", label2: "Flexion", exerciseName: "Wrist Flexion")
                            CustomGaugeTileView(currVal: Float(maxWristExtension), minVal: 0, maxVal: Float(targetWristExtension), label1: "Wrist", label2: "Extension", exerciseName: "Wrist Extension")
                        }
                        .scaledToFit()
                    }
                    
                    if let maxRadialDeviation = viewModel.dashboardData?.maxRadialDeviation, let targetRadialDeviation = viewModel.dashboardData?.targetRadialDeviation, let maxUlnarDeviation = viewModel.dashboardData?.maxUlnarDeviation, let targetUlnarDeviation = viewModel.dashboardData?.targetUlnarDeviation {
                        HStack {
                            CustomGaugeTileView(currVal: Float(maxUlnarDeviation), minVal: 0, maxVal: Float(targetUlnarDeviation), label1: "Ulnar", label2: "Deviation", exerciseName: "Ulnar Deviation")
                            CustomGaugeTileView(currVal: Float(maxRadialDeviation), minVal: 0, maxVal: Float(targetRadialDeviation), label1: "Radial", label2: "Deviation", exerciseName: "Radial Deviation")
                        }
                        .scaledToFit()
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.getDashboardData()
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
            
            VStack {
                Spacer()
                CustomGaugeView(currVal: currVal, minVal: minVal, maxVal: maxVal, label1: label1, label2: label2, exerciseName: exerciseName)
                Spacer()
            }
        }
        .frame(height: 190)
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
                        .font(.system(size: 32))
                        .foregroundStyle(Colours.secondaryTextColour)
                    Text("/\(maxVal.formatted(.number))°")
                        .font(.system(size: 16))
                        .baselineOffset(6)
                        .foregroundStyle(Colours.secondaryTextColour)
                    
                } else {
                    Text("\(currVal.formatted(.number))")
                        .font(.system(size: 32))
                        .foregroundStyle(Colours.secondaryTextColour)
                    Text("/\(maxVal.formatted(.number))")
                        .font(.system(size: 16))
                        .baselineOffset(6)
                        .foregroundStyle(Colours.secondaryTextColour)
                }
            }
        }
        .gaugeStyle(SpeedometerGaugeStyle(label1: label1, label2: label2, maxVal: maxVal, exerciseName: exerciseName))
    }
}

struct SpeedometerGaugeStyle: GaugeStyle {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [ Colours.gaugeLightColour, Colours.gaugeDarkColour ]), startPoint: .trailing, endPoint: .leading)
    
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
                .foregroundColor(.white)
            
            Circle()
                .trim(from: 0, to: 0.75 * maxVal)
                .stroke(Colours.backgroundColour, lineWidth: 20)
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: 0, to: 0.75 * configuration.value)
                .stroke(purpleGradient, lineWidth: 20)
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: 0.75, to: 1)
                .stroke(.white, lineWidth: 20)
                .rotationEffect(.degrees(135))
            
            //            Circle()
            //                .trim(from: 0, to: 0.75)
            //                .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .butt, lineJoin: .round, dash: [1, 100], dashPhase: 0.0))
            //                .rotationEffect(.degrees(135))
            
            VStack {
                configuration.currentValueLabel
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .foregroundStyle(Colours.primaryTextColour)
                Text(label1)
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(Colours.primaryTextColour)
                if let label2 = label2 {
                    Text(label2)
                        .font(.system(.body, design: .rounded))
                        .foregroundStyle(Colours.primaryTextColour)
                }
            }
            
        }
        .frame(height: 150)
    }
}
