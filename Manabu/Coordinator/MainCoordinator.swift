//
//  MainCoordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    var children: [Coordinator]? = []
    
    private var playCoordinator: PlayCoordinator?
    private var learnCoordinator: LearnCoordinator?
    
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
            goToLearn()
        case .homeButtonTapped:
            var homeVC: UIViewController & Coordinating = HomeViewController()
            homeVC.coordinator = self
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func start() {
        guard let tabBarController else { return }
        
        let homeNavigationController = createHomeNavigationController()
        let learnNavigationController = createLearnNavigationController()
        let playNavigationController = createPlayNavigationController()
        
        tabBarController.viewControllers = [homeNavigationController, learnNavigationController, playNavigationController]
        
        self.navigationController = homeNavigationController
    }
    
    func goToPlay() {
        tabBarController?.selectedIndex = 2
    }
    
    func goToLearn() {
        tabBarController?.selectedIndex = 1
    }
}

private extension MainCoordinator {
    func createHomeNavigationController() -> UINavigationController {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        homeViewController.view.backgroundColor = ColorPalette.backgroundColor
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.home, tag: 0)
        homeNavigationController.setViewControllers([homeViewController], animated: false)
        
        return homeNavigationController
    }
    
    func createLearnNavigationController() -> UINavigationController {
        let learnNavigationController = UINavigationController()
        
        learnNavigationController.tabBarItem = UITabBarItem(title: "Learn", image: SFSymbols.learn, tag: 1)
//        learnNavigationController.navigationBar.prefersLargeTitles = true
        
        learnCoordinator = LearnCoordinator(navigationController: learnNavigationController)
        learnCoordinator?.parentCoordinator = self
        children?.append(learnCoordinator!)
        learnCoordinator?.start()
        
        return learnNavigationController
    }
    
    func createPlayNavigationController() -> UINavigationController {
        let playNavigationController = UINavigationController()
        playNavigationController.tabBarItem = UITabBarItem(title: "Play", image: SFSymbols.play, tag: 2)
//        playNavigationController.navigationBar.prefersLargeTitles = true

        playCoordinator = PlayCoordinator(navigationController: playNavigationController)
        playCoordinator?.parentCoordinator = self
        children?.append(playCoordinator!)
        playCoordinator?.start()
        
        return playNavigationController
    }
}
