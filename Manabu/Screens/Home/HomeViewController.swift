//
//  HomeViewController.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import UIKit

class HomeViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    let titleView = ManabuTextLabel(fontSize: 100)
    
    let translationView = ManabuHomeTranslationView()
    let tabStackView = UIStackView()
    
    let playButton = ManabuTextButton()
    let learnButton = ManabuTextButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTitleView()
        configureTranslationView()
        configureTabStackView()
        configureButtons()
    }
}

private extension HomeViewController {
    func configureTitleView() {
        view.addSubview(titleView)
        titleView.text = "学ぶ"
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTranslationView() {
        view.addSubview(translationView)
        
        translationView.translatesAutoresizingMaskIntoConstraints = false
        translationView.layer.cornerRadius = 10
        translationView.backgroundColor = ColorPalette.paper
        
        NSLayoutConstraint.activate([
            translationView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 30),
            translationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            translationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            translationView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureTabStackView() {
        view.addSubview(tabStackView)
        
        tabStackView.translatesAutoresizingMaskIntoConstraints = false
        tabStackView.axis = .vertical
        tabStackView.distribution = .equalSpacing
        
        tabStackView.addArrangedSubview(learnButton)
        tabStackView.addArrangedSubview(playButton)
        
        NSLayoutConstraint.activate([
            tabStackView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            tabStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
            tabStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75),
            tabStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureButtons() {
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        learnButton.set(title: "Learn", color: .darkGray, fontSize: 40, systemImageName: "text.book.closed")
        playButton.set(title: "Play", color: .darkGray, fontSize: 40, systemImageName: "flag.pattern.checkered")
    }
}

private extension HomeViewController {
    @objc func learnButtonTapped() {
        coordinator?.eventOccurred(with: MainEvent.learnButtonTapped)
    }
    
    @objc func playButtonTapped() {
        coordinator?.eventOccurred(with: MainEvent.playButtonTapped)
    }
}
