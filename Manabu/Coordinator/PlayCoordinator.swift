//
//  PlayCoordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import UIKit

class PlayCoordinator: Coordinator {
    var children: [any Coordinator]?
    
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func eventOccurred(with type: CoordinatorEvent) {
        if let playEvent = type as? PlayEvent {
            handlePlayEvent(playEvent)
        }
    }
    
    func handlePlayEvent(_ event: PlayEvent) {
        switch event {
        case .guessHiraganaTapped:
            playGuessHiragana()
        case .guessRomanjiTapped:
            break
        case .drawTapped:
            break
        case .listenTapped:
            break
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = PlayHomeViewController()
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}

private extension PlayCoordinator {
    func playGuessHiragana() {
        var guessHiraganaVC: UIViewController & Coordinating = GuessHiraganaViewController()
        guessHiraganaVC.coordinator = self
        
        navigationController?.pushViewController(guessHiraganaVC, animated: true)
    }
}
