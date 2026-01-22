//
//  MainCoordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {    
    var navigationController: UINavigationController?
    var children: [Coordinator]? = []
    
    func eventOccurred(with type: any CoordinatorEvent) {
        if let mainEvent = type as? MainEvent {
            handleMainEvent(mainEvent)
        }
    }
    
    func handleMainEvent(_ type: MainEvent) {
        switch type {
        case .playButtonTapped:
            goToPlay()
        case .learnButtonTapped:
            var learnVC: UIViewController & Coordinating = LearnViewController()
            learnVC.coordinator = self
            
            navigationController?.pushViewController(learnVC, animated: true)
            
        case .homeButtonTapped:
            var homeVC: UIViewController & Coordinating = HomeViewController()
            homeVC.coordinator = self
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func start() {
        guard let navigationController else { return }
        
        var vc: UIViewController & Coordinating = HomeViewController()
        vc.coordinator = self
        
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func goToPlay() {
        guard let navigationController else { return }
        let playCoordinator = PlayCoordinator.init(navigationController: navigationController)
        
        playCoordinator.parentCoordinator = self
        
        children?.append(playCoordinator)
        
        playCoordinator.start()
    }
}
