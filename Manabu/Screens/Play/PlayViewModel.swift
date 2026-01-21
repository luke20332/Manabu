//
//  PlayViewModel.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import Foundation

final class PlayViewModel {
    
    // MARK: - VM Outputs
    private(set) var streak: Int = 0
    private(set) var prompt: String = ""
    private(set) var options: [PlayOption] = []
    private(set) var shouldShowStreak: Bool = false
    
    // MARK: - Private State
    private var correctOptionID: Int?
    private var numberOfOptions: Int = 4
    
    init() {
        startNewRound()
    }
    
    // MARK: - API called by VC
    func startNewRound() {
        if streak > 2 {
            shouldShowStreak = true
        }
        
        // select the value from dict
        let (promptKey, correctAnswer) = hiraganaDict.randomElement()!
        prompt = promptKey
        
        // randomly choose position to be correct
        let correctIndex = Int.random(in: 0..<numberOfOptions)
        correctOptionID = correctIndex
        
        // options is an array of PlayOptions, each with an index, title, and correct bool
        options = (0..<numberOfOptions).map { index in
            if index == correctIndex {
                return PlayOption(
                    id: index,
                    title: correctAnswer,
                    isCorrect: true,
                    state: .normal
                )
            } else {
                return PlayOption(
                    id: index,
                    title: hiraganaDict.randomElement()!.value,
                    isCorrect: false,
                    state: .normal
                )
            }
        }
    }
    
    func selectOption(id: Int) {
        guard let selectedIndex = options.firstIndex(where: { $0.id == id }),
              let correctID = correctOptionID else { return }
                
        // check the answer - assign streak vals and assign state to playoptions
        
        if id == correctID {
            streak += 1
            options[selectedIndex].state = .correct
        } else {
            streak = 1
            options[selectedIndex].state = .incorrect
            options[correctID].state = .correct
        }
        
        shouldShowStreak = streak > 2
    }
    
    func resetStreakCounter() {
        streak = 0
        shouldShowStreak = false
    }
}
