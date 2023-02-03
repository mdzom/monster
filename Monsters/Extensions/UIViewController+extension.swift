//
//  UIViewController+extension.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 15.01.2023.
//

import UIKit

extension UIViewController {
    
    func createBackgroundImageView(_ image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
    func addConstraintToFullScreen(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
