//
//  PlayViewModel.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import Foundation
import UIKit
import CoreData

final class GuessHiraganaViewModel {
    
    // MARK: - VM Outputs
    private(set) var streak: Int = 0
    private(set) var prompt: String = ""
    private(set) var options: [GuessPlayOption] = []
    private(set) var shouldShowStreak: Bool = false
    
    // MARK: - Private State
    private var correctOptionID: Int?
    private var numberOfOptions: Int = 4
    private var highScore: Int?
    
    // MARK: - CoreData
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var gameModeEntity: GameModeEntity?
    
    init() {
        getHighScore()
        startNewRound()
    }
    
    // MARK: - API called by VC
    func startNewRound() {
        if streak > 2 {
            shouldShowStreak = true
        }
        
        let (promptKey, correctAnswer) = hiraganaDict.randomElement()!
        prompt = promptKey
        
        let correctIndex = Int.random(in: 0..<numberOfOptions)
        correctOptionID = correctIndex
        
        var incorrectOptions = Set<String>()
        
        while incorrectOptions.count < numberOfOptions - 1 {
            let randomElement = hiraganaDict.randomElement()!.value
            
            guard randomElement != correctAnswer else { continue }
            
            incorrectOptions.insert(randomElement)
        }
        
        // options is an array of PlayOptions, each with an index, title, and correct bool
        options = (0..<numberOfOptions).map { index in
            if index == correctIndex {
                return GuessPlayOption(
                    id: index,
                    title: correctAnswer,
                    isCorrect: true,
                    state: .normal
                )
            } else {
                return GuessPlayOption(
                    id: index,
                    title: incorrectOptions.removeFirst(),
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
        updateHighScoreIfNeeded()
    }
    
    func resetStreakCounter() {
        streak = 0
        shouldShowStreak = false
    }
    
    func getHighScore() {
        do {
            let request: NSFetchRequest<GameModeEntity> =  GameModeEntity.fetchRequest()

            request.predicate = NSPredicate(format: "title contains 'Guess the Hiragana'")
            
            gameModeEntity = try context.fetch(request).first!
            
            self.highScore = Int(gameModeEntity?.highScore ?? 0)
        } catch {
            // default error
        }
    }
    
    func updateHighScoreIfNeeded() {
        guard let highScore else {
            return
        }
        
        if streak > highScore {
            self.highScore = streak
            gameModeEntity?.highScore = Int64(streak)
            
            do {
                try self.context.save()
            } catch {
                
            }
        }
    }
}
