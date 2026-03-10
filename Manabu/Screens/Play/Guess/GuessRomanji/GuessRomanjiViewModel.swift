//
//  GuessRomanjiViewModel.swift
//  Manabu
//
//  Created by Luke on 10/03/2026.
//

import Foundation
import UIKit
import CoreData
import Combine

final class GuessRomanjiViewModel: GuessViewModelProtocol {
    
    var streak: Int = 0
    var prompt: String = ""
    var options: [GuessPlayOption] = []
    var shouldShowStreak: Bool = false
    
    private var correctOptionID: Int?
    private var numberOfOptions: Int = 4
    var updateHighScore = PassthroughSubject<Int, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private var highScore: Int?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var gameModeEntity: GameModeEntity?
    
    init() {
        setUpSubscriptions()
        getHighScore()
        startNewRound()
    }
    
    func setUpSubscriptions() {
        updateHighScore
            .sink { _ in
            } receiveValue: { [weak self] result in
                print("sink receive highscore", result)
                self?.highScore = result
            }.store(in: &subscriptions)
    }
    
    // MARK: - API called by VC
    func startNewRound() {
        if streak > 2 {
            shouldShowStreak = true
        }
        
        let (promptKey, correctAnswer) = romanjiDict.randomElement()!
        prompt = promptKey
        
        let correctIndex = Int.random(in: 0..<numberOfOptions)
        correctOptionID = correctIndex
        
        var incorrectOptions = Set<String>()
        
        while incorrectOptions.count < numberOfOptions - 1 {
            let randomElement = romanjiDict.randomElement()!.value
            
            guard randomElement != correctAnswer else { continue }
            
            incorrectOptions.insert(randomElement)
        }
        
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
            request.predicate = NSPredicate(format: "title contains 'Guess the Romanji'")
            gameModeEntity = try context.fetch(request).first!

            updateHighScore.send(Int(gameModeEntity!.highScore))
        } catch {
            updateHighScore.send(0)
        }
    }
    
    func updateHighScoreIfNeeded() {
        guard let highScore else {
            return
        }
        
        if streak > highScore {
            updateHighScore.send(streak)
            gameModeEntity?.highScore = Int64(streak)
            
            do {
                try self.context.save()
            } catch {
                print("XXXX error saving")
            }
        }
    }
}
