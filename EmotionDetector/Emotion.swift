//
//  Emotion.swift
//  EmotionDetector
//
//  Created by Jackson, Ceri-anne (Associate Software Developer) on 17/09/2017.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//
//

enum Emotion: String {
  case Happy
  case Disgust
  case Angry
  case Neutral
  case Sad
  case Fear
  case Surprise
  
  var rawValue: String {
    switch self {
    case .Happy: return "Happy"
    case .Disgust: return "Disgust"
    case .Angry: return "Angry"
    case .Neutral: return "Neutral"
    case .Sad: return "Sad"
    case .Fear: return "Fear"
    case .Surprise: return "Surprise"
    }
  }
  
  var emoticon: String {
    switch self {
    case .Happy: return "😀"
    case .Disgust: return "😨"
    case .Angry: return "😡"
    case .Neutral: return "😐"
    case .Sad: return "☹️"
    case .Fear: return "😱"
    case .Surprise: return "😲"
    }
  }
}

