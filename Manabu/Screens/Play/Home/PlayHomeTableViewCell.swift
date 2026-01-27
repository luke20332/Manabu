//
//  PlayHomeTableViewCell.swift
//  Manabu
//
//  Created by Luke on 22/01/2026.
//

import UIKit

class PlayHomeTableViewCell: UITableViewCell {

    var gameImageView = UIImageView()
    var titleLabel = UILabel()
    var highScoreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(gameImageView)
        addSubview(titleLabel)
        addSubview(highScoreLabel)
        
        configureImageView()
        configureTitleLabel()
        configureHighScoreLabel()
        setImageConstraints()
        setTitleLabelConstraints()
        setHighScoreLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(game: GameMode) {
        self.backgroundColor = ColorPalette.backgroundColor
        gameImageView.image = game.image
        titleLabel.text = game.title
        highScoreLabel.text = "🔥 High Score: \(game.highScore)"
    }
    
    func configureImageView() {
        gameImageView.layer.cornerRadius = 10
        gameImageView.clipsToBounds = true
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
