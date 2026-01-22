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
        //
    }
    
    func start() {
        var vc: UIViewController & Coordinating = HomeViewController()
        
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: false)
    }
}
