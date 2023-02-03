//
//  MyTeamTableViewCell.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 22.01.2023.
//

import UIKit

class MyTeamTableViewCell: UITableViewCell {
    
    weak var viewModel: MyTeamCellVMProtocol? {
        willSet(viewModel) {
            nameLabel.text = viewModel?.name
            levelLabel.text = viewModel?.level
            guard let imageName = viewModel?.image else { return }
            image.image = UIImage(named: imageName)
        }
    }
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = UIFont(name: "SFUIDisplay-Semibold", size: 19)
        view.textColor = .white
        return view
    }()
    
    private lazy var levelLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = UIFont(name: "SFUIDisplay-Light", size: 14)
        view.textColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToView()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToView() {
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(levelLabel)
    }
    
    private func addConstraint() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 118).isActive = true
        image.widthAnchor.constraint(equalToConstant: 118).isActive = true
        image.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        levelLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        levelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    }
}
