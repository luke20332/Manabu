//
//  GuessViewModelProtocol.swift
//  Manabu
//
//  Created by Luke on 10/03/2026.
//

protocol GuessViewModelProtocol {
    func setUpSubscriptions()
    func startNewRound()
    func selectOption(id: Int)
    func updateHighScoreIfNeeded()
    func resetStreakCounter()
    
    var prompt: String {get set}
    var shouldShowStreak: Bool { get set }
    var streak: Int { get set }
    var options: [GuessPlayOption] { get set }
}
