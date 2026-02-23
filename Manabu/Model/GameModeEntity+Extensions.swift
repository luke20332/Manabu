//
//  GameModeEntity+Extensions.swift
//  Manabu
//
//  Created by Luke on 23/02/2026.
//

import Foundation

extension GameModeEntity {
    func toModel() -> GameMode {
        .init(
            imageConfig: generateImageConfig(),
            title: title ?? "",
            highScore: Int(highScore),
            event: PlayEvent(rawValue: eventRaw!)!
        )
    }
    
    func generateImageConfig() -> ImageConfig {
        if let imageType {
            guard let imageValue else {
                return .text("a")
            }
            if imageType == "text" {
                return .text(imageValue)
            } else if imageType == "image" {
                return .image(imageValue)
            } else {
                return .text("b")
            }
        } else {
            return .text("c")
        }
    }
}
