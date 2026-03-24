//
//  PlayCoordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import UIKit
import CoreData

class PlayCoordinator: Coordinator {
    var children: [any Coordinator]?
    
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    
    private var context: NSManagedObjectContext

    init(
        navigationController: UINavigationController,
        context: NSManagedObjectContext
    ) {
        self.navigationController = navigationController
        self.context = context
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
            viewModel: GuessHiraganaViewModel(context: context)
        )
        guessHiraganaVC.coordinator = self
        
        navigationController?.pushViewController(guessHiraganaVC, animated: true)
    }
    
    func playGuessRomanji() {
        var guessRomanjiVC: UIViewController & Coordinating = GuessViewController(
            viewModel: GuessRomanjiViewModel(context: context)
        )
        guessRomanjiVC.coordinator = self
        
        navigationController?.pushViewController(guessRomanjiVC, animated: true)
    }
}
