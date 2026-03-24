//
//  LearnCoordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import Foundation
import UIKit
import CoreData

class LearnCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    var children: [any Coordinator]?
    
    private var context: NSManagedObjectContext
    
    init(
        navigationController: UINavigationController,
        context: NSManagedObjectContext
    ) {
        self.navigationController = navigationController
        self.context = context
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
        var learnHiraganaViewController: UIViewController & Coordinating = LearnViewController(viewModel: LearnViewModel(syllabary: .hiragana, context: context))
        learnHiraganaViewController.coordinator = self
        
        navigationController?.pushViewController(learnHiraganaViewController, animated: true)
    }
    
    func learnKatakana() {
        var learnKatakanaViewController: UIViewController & Coordinating = LearnViewController(viewModel: LearnViewModel(syllabary: .katakana, context: context))
        learnKatakanaViewController.coordinator = self
        
        navigationController?.pushViewController(learnKatakanaViewController, animated: true)
    }
}
