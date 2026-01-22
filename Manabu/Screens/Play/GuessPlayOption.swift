//
//  GuessPlayOption.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

struct GuessPlayOption {
    let id: Int
    let title: String
    let isCorrect: Bool
    var state: State
    
    enum State {
        case normal, correct, incorrect
    }
}
