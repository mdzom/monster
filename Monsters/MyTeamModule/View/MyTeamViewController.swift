//
//  MyTeamViewController.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 14.01.2023.
//

import UIKit

class MyTeamViewController: UIViewController {
    
    let cellIdentifier = "MyTeamCell"
    var viewModel: MyTeamVMProtocol?
    
    private lazy var backgroundImage: UIImageView = {
        createBackgroundImageView(Constants.Images.myTeam)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorInset.left = 0
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTeamTableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyTeamViewModel()
        
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
        
        addConstraintToFullScreen(backgroundImage)
        addConstraintToFullScreen(tableView)
        
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        self.title = "Моя команда"
    }
}

