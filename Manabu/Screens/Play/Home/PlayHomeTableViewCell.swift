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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(gameImageView)
        addSubview(titleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(game: GameMode) {
        gameImageView.image = game.image
        titleLabel.text = game.title
    }
    
    func configureImageView() {
        gameImageView.layer.cornerRadius = 10
        gameImageView.clipsToBounds = true
    }
    
    func configureTitleLabel() {
        titleLabel.numberOfLines = 0 // automatic word wrapping
        titleLabel.adjustsFontSizeToFitWidth = true //wont truncate it
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
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
