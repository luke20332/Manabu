//
//  PlayHomeViewController.swift
//  Manabu
//
//  Created by Luke on 21/01/2026.
//

import UIKit

class PlayHomeViewController: UIViewController, Coordinating {
    var viewModel = PlayHomeViewModel()
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
        viewModel.fetchGames { result in
            switch result {
            case .success(let games):
                self.games = games
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
//        viewModel.oldFetchGames { games in 
//            self.games = games
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = ColorPalette.backgroundColor
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(PlayHomeTableViewCell.self, forCellReuseIdentifier: Cells.playHomeCells)
        tableView.pin(to: view)
        tableView.separatorStyle = .none
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
        let event = games[indexPath.row].event
        
        coordinator?.eventOccurred(with: event)
    }
}
