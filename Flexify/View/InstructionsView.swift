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

    // https://github.com/PRAG0/prago_project_iOS/blob/3efe903f3f334946a47e5bf51415f112dc98e9cc/PARAGO/Lottie.swift#L12
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let imageView = UIImageView()
        if let gif = UIImage.gif(name: gifName) {
            imageView.image = gif
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        // Optionally, set the initial frame and autoresizing behavior
//        imageView.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
//        imageView.frame =CGRect(x: 0, y: 0, width: 500, height: 500) 
        
//        let imageViewX = (UIScreen.main.bounds.width - imageViewWidth) / 2
        
        print("Screen width: \(UIScreen.main.bounds.width)")
        
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)

//            .width = UIScreen.main.bounds.width
//        imageView.frame.height = UIScreen.main.bounds.height
        
        //(width: UIScreen.main.bounds.width, height:100)
        // Do not remove this!
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFit

        view.insertSubview(imageView, at: 0)

        // Force the Image UI view to follow the global view position and dimensions.
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        return view
    }

//    func makeUIView(context: Context) -> UIImageView {
//        let imageView = UIImageView()
//        if let gif = UIImage.gif(name: gifName) {
//            imageView.image = gif
//        }
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        
//        // Optionally, set the initial frame and autoresizing behavior
//        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        return imageView
//    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
            // Update the view if necessary
    }

//    func updateUIView(_ uiView: UIImageView, context: Context) {
//        // Update the view if necessary
//    }
}

struct InstructionsView: View {
    var viewModel: ExerciseViewModel
    
    var body: some View {
        ZStack {
            Colours.backgroundColour.ignoresSafeArea()
            //Wrap the Vstack and leave the proceed to exercise outside
            ScrollView {
            
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
                                GifView(gifName: "wrist_flexion_left")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Wrist flexion exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/flexion_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                    
                                
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/flexion_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                    
                                Text("2. Slowly bend your wrist forward, bringing your palm closer to your forearm. Hold the position for up to 3 seconds")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/flexion_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                    
                                Text("3. Slowly bend your wrist backward to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                            } else {
                                // Replace with images for type1
                                // Insert for right hand
                                GifView(gifName: "wrist_flexion_right")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Wrist flexion exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/flexion_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/flexion_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("2. Slowly bend your wrist forward, bringing your palm closer to your forearm. Hold the position for up to 3 seconds")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/flexion_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("3. Slowly bend your wrist backward to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                            }
                            
                            
                        case .wristExtension:
                            //Insert for left hand
                            //Change the statement
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "wrist_extension_left")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Wrist extension exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/extension_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/extension_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("2. Slowly bend your wrist backward, bringing the back of your hand closer to your forearm.Hold the position for up to 3 seconds")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/extension_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("3. Slowly bend your wrist forward to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                            } else {
                                //Insert for right hand
                                // Replace with images for type2
                                GifView(gifName: "wrist_extension_right")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Wrist extension exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/extension_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("1. Begin with your wrist in a neutral position, neither flexed nor extended. Your fingers should be relaxed")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/extension_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("2. Slowly bend your wrist backward, bringing the back of your hand closer to your forearm.Hold the position for up to 3 seconds")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/extension_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("3. Slowly bend your wrist forward to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                
                            }
                            
                        case .ulnarDeviation:
                            //Insert for left hand
                            //Change the statement
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "ulnar_deviation_left")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Ulnar deviation exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/ulnar_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/ulnar_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("2. Slowly tilt your wrist towards the ulnar side, moving your hand so that your pinky side moves closer to your forearm. Hold this position for up to 3 seconds")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/ulnar_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("3. Slowly tilt your wrist away from the ulnar side to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                            } else {
                                //Insert for right hand
                                // Replace with images for type2
                                GifView(gifName: "ulnar_deviation_right")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Ulnar deviation exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/ulnar_neutral_right")
                                    .resizable()
                                    .padding(31)
                                    .aspectRatio(contentMode: .fit)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/ulnar_down_right")
                                    .resizable()
                                    .padding(31)
                                    .aspectRatio(contentMode: .fit)
                                Text("2. Slowly tilt your wrist towards the ulnar side, moving your hand so that your pinky side moves closer to your forearm. Hold this position for up to 3 seconds")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/ulnar_up_right")
                                    .resizable()
                                    .padding(31)
                                    .aspectRatio(contentMode: .fit)
                                Text("3. Slowly tilt your wrist away from the ulnar side to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                
                            }
                            
                            
                        case .radialDeviation:
                            //Insert for left hand
                            //Change the statement
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "radial_deviation_left")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Radial deviation exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/radial_neutral_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/radial_down_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("2. Slowly tilt your wrist towards the radial side, moving your hand so that your thumb side moves closer to your forearm. Hold this position for up to 3 seconds")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/radial_up_left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("3. Slowly tilt your wrist away from the radial side to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                            } else {
                                //Insert for right hand
                                // Replace with images for type2
                                GifView(gifName: "radial_deviation_right")
                                    .aspectRatio(contentMode: .fit)
                           
                                Text("Radial deviation exercise summary")
                                    .font(.body)
                                    .padding(10)
                                    .foregroundColor(Colours.primaryTextColour)
                                
                                Image("Instructions/radial_neutral_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("1. Begin with your wrist in a neutral position, neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/radial_down_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("2. Slowly tilt your wrist towards the radial side, moving your hand so that your thumb side moves closer to your forearm. Hold this position for up to 3 seconds")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                Image("Instructions/radial_up_right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(31)
                                Text("3. Slowly tilt your wrist away from the radial side to return to neutral position. Repeat this motion as desired")
                                    .font(.body)
                                    .foregroundColor(Colours.primaryTextColour)
                                    .padding(10)
                                
                                
                            }
                            // Add more cases for other exercise types
                            
                            
                            
                        default:
                            Text("No instructions available")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
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
