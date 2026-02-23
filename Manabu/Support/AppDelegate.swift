//
//  AppDelegate.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = persistentContainer
        seedGameModesIfNeeded()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Manabu")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private func seedGameModesIfNeeded() {
        let context = persistentContainer.viewContext
        
        let request: NSFetchRequest<GameModeEntity> = GameModeEntity.fetchRequest()
        
        let count = (try? context.count(for: request)) ?? 0
        
        guard count == 0 else {
            return
        }
        
        let gameModes: [GameMode] = [
            GameMode(
                imageConfig: .text("お"),
                title: "Guess the Hiragana",
                highScore: 0,
                event: .guessHiraganaTapped,
            ),
            GameMode(
                imageConfig: .text("a"),
                title: "Guess the Romanji",
                highScore: 0,
                event: .guessRomanjiTapped,
            ),
            GameMode(
                imageConfig: .image("pencil.and.outline"),
                title: "Draw",
                highScore: 0,
                event: .drawTapped
            ),
            GameMode(
                imageConfig: .image("waveform"),
                title: "Listen",
                highScore: 0,
                event: .listenTapped
            )
        ]
        
        for mode in gameModes {
            let entity = GameModeEntity(context: context)
            
            entity.id = UUID()
            entity.title = mode.title
            entity.highScore = Int64(mode.highScore)
            entity.imageType = mode.imageConfig.imageType
            entity.imageValue = mode.imageConfig.imageValue
            entity.eventRaw = mode.event.rawValue
            
            try? context.save()
        }
        
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

