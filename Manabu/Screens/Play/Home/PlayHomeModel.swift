//
//  PlayHomeModel.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import UIKit

struct GameMode{
    var imageConfig: ImageConfig
    var title: String
    var highScore: Int
    var event: PlayEvent
}

enum ImageConfig {
    case image(systemImageName: String)
    case text(String)
}

extension GameMode: Equatable {
    static func == (lhs: GameMode, rhs: GameMode) -> Bool {
        compareImageConfigs(lhs: lhs.imageConfig, rhs: rhs.imageConfig) &&
        lhs.title == rhs.title &&
        lhs.highScore == rhs.highScore &&
        lhs.event == rhs.event
    }

    private static func compareImageConfigs(lhs: ImageConfig, rhs: ImageConfig) -> Bool {
        switch (lhs, rhs) {
        case (.text(let l), .text(let r)):
            return l == r
        case (.image(let l), .image(let r)):
            return l == r
        default:
            return false
        }
    }
}
