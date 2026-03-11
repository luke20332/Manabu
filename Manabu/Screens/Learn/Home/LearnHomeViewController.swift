//
//  LearnViewController.swift
//  Manabu
//
//  Created by Luke on 19/01/2026.
//

import UIKit

class LearnHomeViewController: UIViewController, Coordinating {
    var viewModel = LearnViewModel()
    var coordinator: Coordinator?
    
    var tableView = UITableView()
    var syllabaries: [Syllabary] = []
    
    struct Cells {
        static let learnHomeCells = "LearnCells"
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Learn"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        
        tableView.backgroundColor = ColorPalette.backgroundColor
        tableView.rowHeight = 100
        tableView.register(LearnHomeTableViewCell.self, forCellReuseIdentifier: Cells.learnHomeCells)
        tableView.pin(to: view)
        tableView.separatorStyle = .none
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchSyllabaries { result in
            switch result {
            case .success(let syllabaries):
                self.syllabaries = syllabaries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                let alert = UIAlertController(
                    title: "Error!",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
            }
        }
        configureTableView()
    }
}

extension LearnHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return syllabaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.learnHomeCells) as! LearnHomeTableViewCell
        let syllabary = syllabaries[indexPath.row]
        cell.set(syllabary: syllabary)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = syllabaries[indexPath.row].event
        
        coordinator?.eventOccurred(with: event)
    }
}
