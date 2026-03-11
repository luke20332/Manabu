//
//  GuessViewController.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class GuessViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    enum Constants {
        static let buttonFontSize: CGFloat = 50
    }
    
    private let viewModel: GuessViewModelProtocol
    
    let streakCounterView = ManabuCounterLabel()
    
    let characterView = ManabuTextLabel(fontSize: 160)
    
    let topStackView = UIStackView()
    let bottomStackView = UIStackView()
    let containerStackView = UIStackView()
    
    let optionOne = ManabuTextButton()
    let optionTwo = ManabuTextButton()
    let optionThree = ManabuTextButton()
    let optionFour = ManabuTextButton()
    
    init(viewModel: GuessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPalette.backgroundColor
        
        view.addSubview(streakCounterView)
        view.addSubview(characterView)
        view.addSubview(containerStackView)
        
        configureStreakCounter()
        configureCharacter()
        configureContainerStackView()
        configureOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.startNewRound()
        viewModel.resetStreakCounter()
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.updateHighScoreIfNeeded()
    }
}

private extension GuessViewController {
    func configureStreakCounter() {
        NSLayoutConstraint.activate([
            streakCounterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            streakCounterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            streakCounterView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCharacter() {
        NSLayoutConstraint.activate([
            characterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func configureContainerStackView() {
        containerStackView.axis = .vertical
        containerStackView.distribution = .fillEqually
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.addArrangedSubview(topStackView)
        containerStackView.addArrangedSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureOptions() {
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        
        topStackView.addArrangedSubview(optionOne)
        topStackView.addArrangedSubview(optionTwo)
        
        bottomStackView.addArrangedSubview(optionThree)
        bottomStackView.addArrangedSubview(optionFour)
        
        addTargets(optionOne, optionTwo, optionThree, optionFour)
    }
    
    func addTargets(_ options: UIButton...) {
        for option in options {
            option.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    func bindViewModel() {
        characterView.text = viewModel.prompt
        
        streakCounterView.isHidden = !viewModel.shouldShowStreak
        streakCounterView.setCount(viewModel.streak)
        
        let buttons = [optionOne, optionTwo, optionThree, optionFour]
        
        for (button, option) in zip(buttons, viewModel.options) {
            button.set(title: option.title, color: ColorPalette.backgroundColor, fontSize: Constants.buttonFontSize, systemImageName: nil)
            
            switch option.state {
            case .normal:
                button.setColor(ColorPalette.backgroundColor)
            case .correct:
                button.setColor(.systemGreen)
            case .incorrect:
                button.setColor(.systemRed)
            }
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // index is the option which corresponds to the sent button
        guard let button = sender as? ManabuTextButton,
              let index = [optionOne, optionTwo, optionThree, optionFour].firstIndex(of: button)
        else { return }
        
        viewModel.selectOption(id: index)
        bindViewModel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.startNewRound()
            self?.bindViewModel()
        }
    }
}
