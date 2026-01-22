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
    
    let romanjiLabel = ManabuTextLabel(fontSize: 20)
    let englishLabel = ManabuTextLabel(fontSize: 20)
    
    let translationStackView = UIStackView()
    let tabStackView = UIStackView()
    
    let playButton = ManabuTextButton()
    let learnButton = ManabuTextButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureTitleView()
        configureTranslationStackView()
        configureTabStackView()
        configureButtons()
    }
}

private extension HomeViewController {
    func configureTitleView() {
        view.addSubview(titleView)
        titleView.text = "学ぶ"
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 200)
        ])
        titleView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureTranslationStackView() {
        view.addSubview(translationStackView)
        
        translationStackView.translatesAutoresizingMaskIntoConstraints = false
        translationStackView.axis = .vertical
        translationStackView.distribution = .fillEqually
        
        translationStackView.addArrangedSubview(romanjiLabel)
        translationStackView.addArrangedSubview(englishLabel)
        
        romanjiLabel.text = "🇯🇵 Manabu"
        romanjiLabel.font = .boldSystemFont(ofSize: 20)
        englishLabel.text = "🇬🇧 Learning / To Learn"
        englishLabel.font = .italicSystemFont(ofSize: 20)
        
        romanjiLabel.textAlignment = .center
        englishLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            translationStackView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 30),
            translationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            translationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            translationStackView.heightAnchor.constraint(equalToConstant: 50)
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
            tabStackView.topAnchor.constraint(equalTo: view.centerYAnchor),
            tabStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tabStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            tabStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureButtons() {
        
        learnButton.addTarget(self, action: #selector(learnButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        learnButton.set(title: "Learn", color: .systemBlue, fontSize: 20, systemImageName: "text.book.closed")
        playButton.set(title: "Play", color: .systemGreen, fontSize: 20, systemImageName: "flag.pattern.checkered")
    }
}

private extension HomeViewController {
    @IBAction func learnButtonTapped() {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func playButtonTapped() {
        tabBarController?.selectedIndex = 2
    }
}
