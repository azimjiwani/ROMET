//
//  InstructionsView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-06.
//

import SwiftUI
import UIKit
import ImageIO

extension UIImage {
    static func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }

        var images = [UIImage]()
        let count = CGImageSourceGetCount(source)
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        return UIImage.animatedImage(with: images, duration: Double(count) / 10.0)
    }

    static func gif(name: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        return gif(data: data)
    }
}

struct GifView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        if let gif = UIImage.gif(name: gifName) {
            imageView.image = gif
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        // Optionally, set the initial frame and autoresizing behavior
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        // Update the view if necessary
    }
}

struct InstructionsView: View {
    var viewModel: ExerciseViewModel
    
    var body: some View {
        ZStack {
            Colours.backgroundColour.ignoresSafeArea()
            //Wrap the Vstack and leave the proceed to exercise outside
            //ScrollView {
            //}
                VStack(alignment: .center){
                    Text(viewModel.exercise?.name ?? "NULL")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(20)
                        .foregroundStyle(Colours.primaryTextColour)
                    
                    //TODO:
                    //Make instructions for all four exercises respectively
                    //Check the connection between the ExerciseListView and InstructionsView to ensure consistency
                    //Make wrapper for gifs
                    Group {
                        switch viewModel.exercise?.type {
                        case .wristFlexion:
                            //Insert for left hand
                            if viewModel.exercise?.hand == true {
                                //Insert gif
//                                GifView(gifName: "wrist_flexion")
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: UIScreen.main.bounds.width, height:100)
                                Text("Animated instruction for wrist flexion")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/flexion_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                        
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/flexion_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                                Text("2. Slowly bend your wrist forward, bringing your palm closer to your forearm. Hold the position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/flexion_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                                Text("3. Slowly bend your wrist backward to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                // Replace with images for type1
                                // Insert for right hand
                                Image("Instructions/flexion_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/flexion_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly bend your wrist forward, bringing your palm closer to your forearm. Hold the position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/flexion_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly bend your wrist backward to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            
                        case .wristExtension:
                            //Insert for left hand
                            //Change the statement
                            if viewModel.exercise?.hand == true {
                                Image("Instructions/extension_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/extension_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly bend your wrist backward, bringing the back of your hand closer to your forearm.Hold the position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/extension_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly bend your wrist forward to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                //Insert for right hand
                                // Replace with images for type2
                                Image("Instructions/extension_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/extension_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly bend your wrist backward, bringing the back of your hand closer to your forearm.Hold the position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/extension_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly bend your wrist forward to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                
                            }
                            
                        case .ulnarDeviation:
                            //Insert for left hand
                            //Change the statement
                            if viewModel.exercise?.hand == true {
                                Image("Instructions/ulnar_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/ulnar_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly tilt your wrist towards the ulnar side, moving your hand so that your pinky side moves closer to your forearm. Hold this position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/ulnar_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly tilt your wrist away from the ulnar side to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                //Insert for right hand
                                // Replace with images for type2
                                Image("Instructions/ulnar_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/ulnar_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly tilt your wrist towards the ulnar side, moving your hand so that your pinky side moves closer to your forearm. Hold this position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/ulnar_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly tilt your wrist away from the ulnar side to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                
                            }
                            
                            
                        case .radialDeviation:
                            //Insert for left hand
                            //Change the statement
                            if viewModel.exercise?.hand == true {
                                Image("Instructions/radial_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/radial_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly tilt your wrist towards the radial side, moving your hand so that your thumb side moves closer to your forearm. Hold this position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/radial_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly tilt your wrist away from the radial side to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            } else {
                                //Insert for right hand
                                // Replace with images for type2
                                Image("Instructions/radial_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/radial_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly tilt your wrist towards the radial side, moving your hand so that your thumb side moves closer to your forearm. Hold this position for 5-10 seconds")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Image("Instructions/radial_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly tilt your wrist away from the radial side to return to neutral position. Repeat this motion as desired")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                
                            }
                            // Add more cases for other exercise types
                            
                            
                            
                        default:
                            Text("No instructions available")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                NavigationLink(destination: ExerciseView(viewModel: viewModel).toolbar(.hidden, for: .tabBar)) {
                    Text("Proceed To Exercise")
                        .font(.headline)
                        .foregroundStyle(Colours.buttonTextColour)
                        .padding()
                        .background(Colours.buttonBackgroundColour)
                        .frame(height: 40)
                        .cornerRadius(20)
                }
                Spacer()
            }
        }
    }
}
