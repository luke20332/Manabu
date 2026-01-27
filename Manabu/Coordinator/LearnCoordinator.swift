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
        case .homeButtonTapped:
            parentCoordinator?.navigationController?.tabBarController?.selectedIndex = 0
        case .hirganaFlashCardsTapped:
            break
        case .romanjiFlashCardsTapped:
            break
        case .listenTapped:
            break
        case .drawTapped:
            break
        }
    }
    
    func start() {
        var learnViewController: UIViewController & Coordinating = LearnViewController()
        learnViewController.coordinator = self
        learnViewController.view.backgroundColor = ColorPalette.backgroundColor
        
        navigationController?.setViewControllers([learnViewController], animated: true)
    }
}
