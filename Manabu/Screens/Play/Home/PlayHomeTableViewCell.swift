//
//  PlayHomeTableViewCell.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import UIKit

class PlayHomeTableViewCell: UITableViewCell {
    var gameImageView = UIImageView()
    var textImageView = UILabel()
    var titleLabel = UILabel()
    var highScoreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(gameImageView)
        addSubview(textImageView)
        addSubview(titleLabel)
        addSubview(highScoreLabel)
        
        configureImageView()
        configureTextImageView()
        configureTitleLabel()
        configureHighScoreLabel()
        
        setTextImageConstraints()
        setImageConstraints()
        setTitleLabelConstraints()
        setHighScoreLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(game: GameMode) {
        self.backgroundColor = ColorPalette.backgroundColor
        
        switch game.imageConfig {
        case .image(let image):
            gameImageView.image = image
            gameImageView.isHidden = false
            textImageView.isHidden = true
//            gameImageView.tintColor = .systemGray
        case .text(let text):
            textImageView.text = text
            textImageView.isHidden = false
            gameImageView.isHidden = true
        }
        
        
        titleLabel.text = game.title
        highScoreLabel.text = "🔥 High Score: \(game.highScore)"
    }
    
    func configureTextImageView() {
        textImageView.textAlignment = .center
        textImageView.font = .systemFont(ofSize: 60, weight: .semibold)
        textImageView.textColor = .label
        textImageView.adjustsFontForContentSizeCategory = true
    }
    
    func configureImageView() {
        gameImageView.layer.cornerRadius = 10
        gameImageView.clipsToBounds = true
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.tintColor = .label
    }
    
    func configureTitleLabel() {
        titleLabel.numberOfLines = 0 // automatic word wrapping
        titleLabel.adjustsFontSizeToFitWidth = true //wont truncate it
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    
    func configureHighScoreLabel() {
        highScoreLabel.numberOfLines = 0
        highScoreLabel.adjustsFontSizeToFitWidth = true
        highScoreLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    func setTextImageConstraints() {
        textImageView.translatesAutoresizingMaskIntoConstraints = false
        textImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        textImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        textImageView.widthAnchor.constraint(equalTo: textImageView.heightAnchor).isActive = true
    }
    
    func setImageConstraints() {
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        gameImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        gameImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        gameImageView.widthAnchor.constraint(equalTo: gameImageView.heightAnchor).isActive = true
    }
    
    func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
    func setHighScoreLabelConstraints() {
        highScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highScoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            highScoreLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 20),
            highScoreLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
