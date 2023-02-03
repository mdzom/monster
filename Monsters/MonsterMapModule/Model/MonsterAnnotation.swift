//
//  MonsterAnnotation.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 17.01.2023.
//

import Foundation
import MapKit

final class MonsterAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(location: CLLocationCoordinate2D, title: String) {
        coordinate = location
        self.title = title
        self.subtitle = nil
    }
    
    static func addMonsterAnnotation(_ location: CLLocationCoordinate2D) -> MonsterAnnotation {
        let name = ["Grizl", "Hipe", "Serp", "Morder", "Slept"].randomElement() ?? ""
        return MonsterAnnotation(location: location, title: name)
    }
}

