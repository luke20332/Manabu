//
//  LearnHiraganaViewController.swift
//  Manabu
//
//  Created by Luke on 11/03/2026.
//

import Foundation
import UIKit

class LearnHiraganaViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    private let viewModel: LearnHiraganaViewModel
    
    let flashcardView = FlashcardView(syllabary: .hiragana, reversingAllowed: true)
    
    let buttonStackView = UIStackView()
    let leftButton = ManabuTextButton()
    let rightButton = ManabuTextButton()
    
    init(viewModel: LearnHiraganaViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPalette.backgroundColor
        
        view.addSubview(flashcardView)
        view.addSubview(buttonStackView)
        
        configureFlashcardView()
        configureButtons()
        configureStackView()
    }
    
    func configureButtons() {
        leftButton.set(
            title: "<",
            color: ColorPalette.backgroundColor,
            fontSize: 50,
            systemImageName: nil
        )
        
        rightButton.set(
            title: ">",
            color: ColorPalette.backgroundColor,
            fontSize: 50,
            systemImageName: nil
        )
        
        leftButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        
        rightButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        leftButton.tintColor = .red
        rightButton.tintColor = .blue
    }
    
    func configureStackView() {
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillProportionally
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStackView.addArrangedSubview(leftButton)
        buttonStackView.addArrangedSubview(rightButton)
        
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureFlashcardView() {
        guard let character = viewModel.currentCharacter else {
            return
        }
    
        flashcardView.translatesAutoresizingMaskIntoConstraints = false
        flashcardView.set(character)
//        flashcardView.layer.cornerRadius = 50
        
        NSLayoutConstraint.activate([
            flashcardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            flashcardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            flashcardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            flashcardView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
    }
}

private extension LearnHiraganaViewController {
    @objc func previousButtonTapped() {
        flashcardView.set(viewModel.previousCharacter() ?? "")
    }
    
    @objc func nextButtonTapped() {
        flashcardView.set(viewModel.nextCharacter() ?? "")
    }
}
