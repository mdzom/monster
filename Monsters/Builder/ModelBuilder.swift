//
//  ModelBuilder.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 17.01.2023.
//

import UIKit

class ModelBuilder: Builder {
    static func createGeolocationRequestModule() -> UIViewController {
        let vc = GeolocationRequestViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        return vc
    }
    
    static func createMonsterMapModule() -> UIViewController {
        let vc = MonsterMapViewController()
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        return navigation
    }
    
    static func createMonsterCaptureModule(_ name: String) -> UIViewController {
        let vc = MonsterCaptureViewController()
        vc.name = name
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        return vc
    }
    
    static func createMyTeamModule() -> UIViewController {
        let vc = MyTeamViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        return vc
    }
}

