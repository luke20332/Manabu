//
//  PlayHomeModel.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import UIKit

struct GameMode {
    var imageConfig: ImageConfig
    var title: String
    var highScore: Int
    var event: PlayEvent
}

enum ImageConfig {
    case image(String)
    case text(String)
    
    var imageType: String {
        switch self {
        case .image:
            return "image"
        case .text:
            return "text"
        }
    }
    
    var imageValue: String? {
        switch self {
        case .image(let imageString):
            return imageString
        case .text(let text):
            return text
        }
    }
}
