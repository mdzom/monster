//
//  MonsterMapViewController+extension.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 17.01.2023.
//

import MapKit

extension MonsterMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDisplayedMonsters()
    }
}

extension MonsterMapViewController: MKMapViewDelegate {
    //MARK: срабатывает при добавлении нового POI
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = UUID().uuidString
        guard !(annotation is MKUserLocation) else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        guard let imageName = annotation.title,
              let imageName,
              let image = UIImage(named: imageName) else { return nil }
        
        let button = UIButton(frame: CGRect(x: 0, y: 0,
                                            width: 30,
                                            height: 30))
        button.setImage(image, for: .normal)
        annotationView?.rightCalloutAccessoryView = button
        annotationView?.image = image
        annotationView?.frame = CGRect(x: 0, y: 0,
                                       width: 50,
                                       height: 50)
        return annotationView
    }
    
    //MARK: срабатывает при нажатиии кпопки в POI
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? MonsterAnnotation,
              let removeIndex = monsters.firstIndex(of: annotation),
              let title = annotation.title else { return }
        
        
        let userLocation = mapView.userLocation.coordinate
        let distance = CLLocation(latitude: userLocation.latitude,
                                  longitude: userLocation.longitude).distance(from: CLLocation(latitude: annotation.coordinate.latitude,
                                                                                               longitude: annotation.coordinate.longitude))
        //MARK: дистанция для поимки
        if distance <= 100 {
            mapView.removeAnnotation(annotation)
            monsters.remove(at: removeIndex)
            let controller = ModelBuilder.createMonsterCaptureModule(title)
            present(controller, animated: true)
        } else {
            runTooFarAlert(distance: distance)
        }
    }
}


