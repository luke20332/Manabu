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
            playGuessRomanji()
        case .drawTapped:
            break
        case .listenTapped:
            break
        }
    }
    
    func start() {
        var playViewController: UIViewController & Coordinating = PlayHomeViewController()
        playViewController.coordinator = self
        playViewController.view.backgroundColor = ColorPalette.backgroundColor

        navigationController?.setViewControllers([playViewController], animated: false)
    }
}

private extension PlayCoordinator {
    func playGuessHiragana() {
        var guessHiraganaVC: UIViewController & Coordinating = GuessViewController(
            viewModel: GuessHiraganaViewModel()
        )
        guessHiraganaVC.coordinator = self
        
        navigationController?.pushViewController(guessHiraganaVC, animated: true)
    }
    
    func playGuessRomanji() {
        var guessRomanjiVC: UIViewController & Coordinating = GuessViewController(
            viewModel: GuessRomanjiViewModel()
        )
        guessRomanjiVC.coordinator = self
        
        navigationController?.pushViewController(guessRomanjiVC, animated: true)
    }
}
