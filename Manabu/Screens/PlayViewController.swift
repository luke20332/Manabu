//
//  PlayViewController.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class PlayViewController: UIViewController {
    
    let characterView = ManabuTextLabel(fontSize: 160)
    
    let topStackView = UIStackView()
    let bottomStackView = UIStackView()
    let containerStackView = UIStackView()
    
    let optionOne = ManabuTextButton()
    let optionTwo = ManabuTextButton()
    let optionThree = ManabuTextButton()
    let optionFour = ManabuTextButton()
    
    var prompt: String = ""
    var answer: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(characterView)
        view.addSubview(containerStackView)
        
        configureCharacter()
        configureContainerStackView()
        configureOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateValues()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let button = sender as? ManabuTextButton,
              let guess = button.text
        else {
            print("fail")
            return
        }
        
        checkAnswer(guess)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.updateValues()
        }
    }
}

private extension PlayViewController {
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
        
        optionOne.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        optionTwo.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        optionThree.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        optionFour.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func updateValues() {
        view.backgroundColor = .systemBackground
        let randomIndex = Int(arc4random_uniform(4))
        var counter = 0
        let (answerKey, answerValue) = hiraganaDict.randomElement()!
        
        prompt = answerKey
        answer = answerValue
        
        let options = [optionOne, optionTwo, optionThree, optionFour]
        
        characterView.text = answerKey
        
        options.forEach {
            if counter == randomIndex {
                $0.set(title: answerValue, color: .systemBackground)
            } else {
                $0.set(title: hiraganaDict.randomElement()!.value, color: .systemBackground)
            }
            counter += 1
        }
    }
    
    func checkAnswer(_ guess: String) {
        if guess == hiraganaDict[prompt] {
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .red
        }
    }
    
}
