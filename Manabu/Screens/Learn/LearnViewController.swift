//
//  LearnViewController.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class LearnViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        title = "Learn"
       
        configureButton()
    }
    
    func configureButton() {
        let button = ManabuTextButton(title: "Home", color: .systemGreen, fontSize: 20, systemImageName: "a_english")
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        coordinator?.eventOccurred(with: MainEvent.homeButtonTapped)
    }
}
