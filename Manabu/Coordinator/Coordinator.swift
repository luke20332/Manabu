//
//  Coordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import Foundation
import UIKit

protocol CoordinatorEvent {}

enum MainEvent: CoordinatorEvent {
    case playButtonTapped
    case learnButtonTapped
    case homeButtonTapped
}

enum PlayEvent: CoordinatorEvent {
    case guessHiraganaTapped
    case guessRomanjiTapped
    case drawTapped
    case listenTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var children: [Coordinator]? { get set }
    
    func eventOccurred(with type: CoordinatorEvent)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
