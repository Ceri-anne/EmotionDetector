//
//  EmotionDetector.swift
//  EmotionDetector
//
//  Created by Jackson, Ceri-anne (Associate Software Developer) on 17/09/2017.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import Foundation
import CoreML
import Vision

final class EmotionDetector {

  static let shared = EmotionDetector()
  
  var emotion: Emotion?
  var confidence: Int?
  
  func detectEmotion(image: CIImage) {
    guard let model = try? VNCoreMLModel(for: CNNEmotions().model) else {
      fatalError("can't load CNNEmotions ML model")
    }
    
    let request = VNCoreMLRequest(model: model, completionHandler: classify)
    
    let handler = VNImageRequestHandler(ciImage: image)
    DispatchQueue.global(qos: .userInteractive).async {
      do {
        try handler.perform([request])
      } catch {
        print(error)
      }
    }
  }
  
  @objc
  func classify(request: VNRequest, error: Error?)  {
    
    guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
      fatalError("cannot classify")
    }
    
    emotion = Emotion(rawValue: topResult.identifier)
    confidence = Int(topResult.confidence * 100)
    
    NotificationCenter.default.post(name: Notification.Name("Update Emotion"), object: nil)
  }

}
