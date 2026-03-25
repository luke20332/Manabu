//
//  RandomKanjiViewController.swift
//  Manabu
//
//  Created by Luke on 25/03/2026.
//

import UIKit

class RandomKanjiViewController: UIViewController, Coordinating {
    private let viewModel: RandomKanjiViewModelProtocol
    
    var coordinator: Coordinator?
    
    private var flashcardView = FlashcardView(syllabary: .kanji)
    private var translationView = ManabuHomeTranslationView()
    private var character: String {
        viewModel.getRandomCharacter()
    }
    
    init(viewModel: RandomKanjiViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configure()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = coordinator?.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    private func configure() {
        view.backgroundColor = ColorPalette.backgroundColor
        view.addSubview(flashcardView)
        view.addSubview(translationView)
        
        configureFlashcardView()
        configureTranslationView()
        
    }
    
    private func configureFlashcardView() {
        flashcardView.translatesAutoresizingMaskIntoConstraints = false
//        flashcardView.set(String(character))
        
        NSLayoutConstraint.activate([
            flashcardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            flashcardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            flashcardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            flashcardView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
    }
    
    private func configureTranslationView() {
        translationView.translatesAutoresizingMaskIntoConstraints = false
        translationView.layer.cornerRadius = 10
        translationView.backgroundColor = ColorPalette.paper
        
        NSLayoutConstraint.activate([
            translationView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            translationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            translationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            translationView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func bindViewModel() {
        Task {
            let character = viewModel.getRandomCharacter()
            
            do {
                let characterInformation = try await viewModel.fetchCharacterInformation(character: character)
                
                await MainActor.run {
                    flashcardView.set(character)
                    translationView.set(
                        hiraganaTranslation: character,
                        kanji: characterInformation.kanji,
                        definitions: characterInformation.meanings,
                        pronounciation: characterInformation.heisig ?? "?"
                    )
                }
            } catch let error {
                print("XXX error \(error) ")
            }
        }
    }
}
