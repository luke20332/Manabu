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
    
    func eventOccurred(with type: Event) {
        switch type {
        case .playButtonTapped:
            var playVC: UIViewController & Coordinating = PlayHomeViewController()
            playVC.coordinator = self
            
            navigationController?.pushViewController(playVC, animated: true)
            
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
        var vc: UIViewController & Coordinating = HomeViewController()
        
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}
