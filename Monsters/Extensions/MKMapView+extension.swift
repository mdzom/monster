//
//  MKMapView+extension.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 17.01.2023.
//

import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation,
                          regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        //MARK: false - сразу будет показана область 1000м без анимации
        setRegion(coordinateRegion, animated: true)
    }
}
