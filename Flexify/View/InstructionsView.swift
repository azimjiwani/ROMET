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
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let imageView = UIImageView()
        if let gif = UIImage.gif(name: gifName) {
            imageView.image = gif
        }
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFit
        
        view.insertSubview(imageView, at: 0)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if necessary
    }
}

struct InstructionsView: View {
    var viewModel: ExerciseViewModel
    
    var body: some View {
        ZStack {
            Colours.backgroundColour.ignoresSafeArea()
            ScrollView {
                
                VStack(alignment: .center){
                    Text(viewModel.exercise?.name ?? "NULL")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                        .foregroundStyle(Colours.primaryTextColour)
                    
                    Group {
                        switch viewModel.exercise?.type {
                        case .wristFlexion:
                            //Insert for left hand
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "wrist_flexion_left")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the ulnar side (pinky side) toward the camera, ensuring it's neither flexed nor extended. Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly bend your wrist forward, drawing your palm closer to your forearm. Hold this position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually bend your wrist backward, returning it to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                            } else {
                                GifView(gifName: "wrist_flexion_right")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the ulnar side (pinky side) toward the camera, ensuring it's neither flexed nor extended. Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly bend your wrist forward, drawing your palm closer to your forearm. Hold this position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually bend your wrist backward, returning it to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            }
                            
                            
                        case .wristExtension:
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "wrist_extension_left")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the ulnar side (pinky side) toward the camera, ensuring it's neither flexed nor extended. Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly bend your wrist backward, bringing the back of your hand closer to your forearm. Hold the position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually bend your wrist forward to return to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                            } else {
                                GifView(gifName: "wrist_extension_right")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the ulnar side (pinky side) toward the camera, ensuring it's neither flexed nor extended. Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly bend your wrist backward, bringing the back of your hand closer to your forearm. Hold the position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually bend your wrist forward to return to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            }
                            
                        case .ulnarDeviation:
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "ulnar_deviation_left")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the back of your hand to face the camera, ensuring it is neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly tilt your wrist towards the ulnar side, moving your hand so that the pinky side comes closer to your forearm. Hold this position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually tilt your wrist away from the ulnar side to return to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                            } else {
                                GifView(gifName: "ulnar_deviation_right")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the back of your hand to face the camera, ensuring it is neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly tilt your wrist towards the ulnar side, moving your hand so that the pinky side comes closer to your forearm. Hold this position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually tilt your wrist away from the ulnar side to return to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                            }
                            
                        case .radialDeviation:
                            if viewModel.exercise?.hand == true {
                                GifView(gifName: "radial_deviation_left")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the palm to face the camera, ensuring it is neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly tilt your wrist towards the radial side, moving your hand so that the thumb side comes closer to your forearm. Hold this position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually tilt your wrist away from the radial side to return to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                            } else {
                                GifView(gifName: "radial_deviation_right")
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .background(.white)
                                    .cornerRadius(15)
                                    .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Instructions")
                                        .font(.headline)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("1. Begin with your wrist in a neutral position, positioning the palm to face the camera, ensuring it is neither deviated towards the ulnar side (pinky side) nor the radial side (thumb side). Keep your fingers relaxed.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("2. Slowly tilt your wrist towards the radial side, moving your hand so that the thumb side comes closer to your forearm. Hold this position for up to 3 seconds.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("3. Gradually tilt your wrist away from the radial side to return to the neutral position. Repeat this motion as desired.")
                                        .font(.body)
                                        .foregroundColor(Colours.primaryTextColour)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 10)
                            }
                            
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
