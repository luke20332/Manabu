//
//  Coordinator.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import Foundation
import UIKit

enum Event {
    case playButtonTapped
    case learnButtonTapped
    case homeButtonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var children: [Coordinator]? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
