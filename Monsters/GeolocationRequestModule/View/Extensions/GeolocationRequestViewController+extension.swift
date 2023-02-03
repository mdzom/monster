//
//  GeolocationRequestViewController+extension.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 15.01.2023.
//

import MapKit

extension GeolocationRequestViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            goToMap()
            break
        case .denied, .restricted:
            transitionAnimation(Constants.Images.forbidden)
            noAccessAlert()
            break
        default:
            break
        }
    }
    
    private func goToMap() {
        let controller = ModelBuilder.createMonsterMapModule()
        present(controller, animated: true)
    }
}
