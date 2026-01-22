//
//  PlayHomeViewController.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import UIKit

class PlayHomeViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    var tableView = UITableView()
    var games: [GameMode] = []
    
    struct Cells {
        static let playHomeCells = "PlayCells"
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Play"
        games = fetchGames()
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(PlayHomeTableViewCell.self, forCellReuseIdentifier: Cells.playHomeCells)
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PlayHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.playHomeCells) as! PlayHomeTableViewCell
        let game = games[indexPath.row]
        cell.set(game: game)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.eventOccurred(with: PlayEvent.guessHiraganaTapped)
    }
}

private extension PlayHomeViewController {
    func fetchGames() -> [GameMode] {
        let game1 = GameMode(image: Images.a_hiragana, title: "Guess the hiragana")
        let game2 = GameMode(image: Images.a_english, title: "Guess the romanji")
        let game3 = GameMode(image: SFSymbols.draw, title: "Draw")
        let game4 = GameMode(image: SFSymbols.listen, title: "Listen")
        
        return [game1, game2, game3, game4]
    }
}
