//
//  LearnCoordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import Foundation
import UIKit

class LearnCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    var children: [any Coordinator]?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func eventOccurred(with type: any CoordinatorEvent) {
        if let learnEvent = type as? LearnEvent {
            handleLearnEvent(learnEvent)
        }
    }
    
    func handleLearnEvent(_ type: LearnEvent) {
        switch type {
        case .hiraganaFlashCardsTapped:
            learnHiragana()
        case .katakanaFlashCardsTapped:
            learnKatakana()
        case .listenTapped:
            break
        case .drawTapped:
            break
        }
    }
    
    func start() {
        var learnHomeViewController: UIViewController & Coordinating = LearnHomeViewController()
        learnHomeViewController.coordinator = self
        learnHomeViewController.view.backgroundColor = ColorPalette.backgroundColor
        
        navigationController?.setViewControllers([learnHomeViewController], animated: true)
    }
}

private extension LearnCoordinator {
    func learnHiragana() {
        var learnHiraganaViewController: UIViewController & Coordinating = LearnViewController(viewModel: LearnViewModel(syllabary: .hiragana))
        learnHiraganaViewController.coordinator = self
        
        navigationController?.pushViewController(learnHiraganaViewController, animated: true)
    }
    
    func learnKatakana() {
        var learnKatakanaViewController: UIViewController & Coordinating = LearnViewController(viewModel: LearnViewModel(syllabary: .katakana))
        learnKatakanaViewController.coordinator = self
        
        navigationController?.pushViewController(learnKatakanaViewController, animated: true)
    }
}
