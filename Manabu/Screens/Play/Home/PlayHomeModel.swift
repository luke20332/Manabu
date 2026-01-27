//
//  PlayHomeModel.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import UIKit

struct GameMode {
//    var image: UIImage
    var imageConfig: ImageConfig
    var title: String
    var highScore: Int
    var event: PlayEvent
    
    // subtitle?
}

enum ImageConfig {
    case image(UIImage)
    case text(String)
}
