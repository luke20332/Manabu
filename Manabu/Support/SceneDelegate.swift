//
//  SceneDelegate.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let coordinator = MainCoordinator()
        let tabBarController = UITabBarController()
        
        let window = UIWindow(windowScene: windowScene)

        coordinator.tabBarController = tabBarController
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
        
        coordinator.start()
    }
    
//    func createTabBar() -> UITabBarController {
//        let tabBar = UITabBarController()
//        UITabBar.appearance().barTintColor = .systemGreen
//        tabBar.viewControllers = [
//            createHomeNavigationController(),
//            createLearnNavigationController(),
//            createPlayNavigationController()
//        ]
//        
//        return tabBar
//    }
//    
//    func createHomeNavigationController() -> UINavigationController {
//        let homeVC = HomeViewController()
//        homeVC.title = "Home"
//        homeVC.tabBarItem = UITabBarItem(title: "Home", image: SFSymbols.home, tag: 0)
//        
//        return UINavigationController(rootViewController: homeVC)
//    }
//    
//    func createPlayNavigationController() -> UINavigationController {
//        let playVC = PlayHomeViewController()
//        playVC.title = "Play"
//        playVC.tabBarItem = UITabBarItem(title: "Play", image: SFSymbols.play, tag: 2)
//        
//        return UINavigationController(rootViewController: playVC)
//    }
//    
//    func createLearnNavigationController() -> UINavigationController {
//        let learnVC = LearnViewController()
//        learnVC.title = "Learn"
//        learnVC.tabBarItem = UITabBarItem(title: "Learn", image: SFSymbols.learn, tag: 1)
//        
//        return UINavigationController(rootViewController: learnVC)
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

