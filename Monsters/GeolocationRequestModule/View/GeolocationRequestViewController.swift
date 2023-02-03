//
//  GeolocationRequestViewController.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 15.01.2023.
//

import UIKit
import CoreLocation

class GeolocationRequestViewController: UIViewController {
    
    private lazy var locationManager = CLLocationManager()
    private lazy var backgroundImage: UIImageView = {
        createBackgroundImageView(Constants.Images.start)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        addConstraintToFullScreen(backgroundImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAlert()
    }
    
    private func goToSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func geolocationRequest() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func transitionAnimation(_ image: UIImage) {
        UIView.transition(with: backgroundImage,
                          duration: 0.4,
                          options: .transitionCrossDissolve) { [weak self] in
            self?.backgroundImage.image = image
        }
    }
    
    private func startAlert() {
        let alert = UIAlertController(title: nil,
                                      message: Constants.Strings.messageStart,
                                      preferredStyle: .alert)
        let allowAction = UIAlertAction(title: Constants.Strings.buttonAllow,
                                        style: .default) { [weak self] _ in
            self?.transitionAnimation(Constants.Images.inquiry)
            self?.accessRequestAlert()
        }
        alert.addAction(allowAction)
        present(alert, animated: true)
    }
    
    private func accessRequestAlert() {
        let alert = UIAlertController(title: Constants.Strings.title,
                                      message: Constants.Strings.messageAccessRequest,
                                      preferredStyle: .alert)
        let allowAction = UIAlertAction(title: Constants.Strings.buttonAllow,
                                        style: .default) { [weak self] _ in
            self?.geolocationRequest()
        }
        alert.addAction(allowAction)
        let banAction = UIAlertAction(title: Constants.Strings.buttonDoNotAllow,
                                      style: .default) { [weak self] _ in
            self?.transitionAnimation(Constants.Images.forbidden)
            self?.noAccessAlert()
        }
        alert.addAction(banAction)
        present(alert, animated: true)
    }
    
    func noAccessAlert() {
        let alert = UIAlertController(title: nil,
                                      message: Constants.Strings.messageNoAccess,
                                      preferredStyle: .alert)
        let goToSettingsAction = UIAlertAction(title: Constants.Strings.buttonSettings,
                                               style: .default) { [weak self] _ in
            self?.goToSettings()
        }
        alert.addAction(goToSettingsAction)
        present(alert, animated: true)
    }
}
