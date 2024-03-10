//
//  DemoCameraView.swift
//  Flexify
//
//  Created by Azim Jiwani on 2024-03-08.
//

import SwiftUI
import AVFoundation
import UIKit
import Vision

struct CameraView: View {
    var body: some View {
        CameraPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct CameraPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> CameraPreviewView {
        return CameraPreviewView()
    }
    
    func updateUIView(_ uiView: CameraPreviewView, context: Context) {}
}

class CameraPreviewView: UIView {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCaptureSession()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Front camera not available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch {
            print("Error setting up front camera input: \(error.localizedDescription)")
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = bounds
        previewLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
}

extension CameraPreviewView: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        
        let request = VNDetectHumanBodyPoseRequest(completionHandler: detectedLandmarks)
        do {
            try imageRequestHandler.perform([request])
        } catch {
            print("Error performing request: \(error)")
        }
    }
    
    func detectedLandmarks(request: VNRequest, error: Error?) {
        guard let bodyObservations = request.results as? [VNHumanBodyPoseObservation] else { return }
        
        guard let handObservations = request.results as? [VNHumanHandPoseObservation] else { return }
        
        for bodyObservation in bodyObservations {
            guard let elbowLandmark = try? bodyObservation.recognizedPoint(.leftElbow),
                  let wristLandmark = try? bodyObservation.recognizedPoint(.leftWrist) else { continue }
            
            
            let elbowPoint = CGPoint(x: elbowLandmark.location.x * bounds.width,
                                     y: (1 - elbowLandmark.location.y) * bounds.height)
            let wristPoint = CGPoint(x: wristLandmark.location.x * bounds.width,
                                     y: (1 - wristLandmark.location.y) * bounds.height)
            
            var pinkyPoint = CGPoint(x: 0, y: 0)
            
            for handObservation in handObservations {
                guard let pinkyLandmark = try? handObservation.recognizedPoint(.littleTip) else { continue }
                
                pinkyPoint = CGPoint(x: pinkyLandmark.location.x * bounds.width,
                                     y: (1 - pinkyLandmark.location.y) * bounds.height)
                
            }
            
            DispatchQueue.main.async {
                self.drawCircle(at: elbowPoint, color: UIColor.red)
                self.drawCircle(at: wristPoint, color: UIColor.green)
                self.drawCircle(at: pinkyPoint, color: UIColor.blue)
            }
        }
    }
    
    func drawCircle(at point: CGPoint, color: UIColor) {
        let circlePath = UIBezierPath(arcCenter: point, radius: 5, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2.0
        layer.addSublayer(shapeLayer)
    }
}
