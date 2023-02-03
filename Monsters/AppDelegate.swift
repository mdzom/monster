//
//  AppDelegate.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 12.01.2023.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let initialViewController = isGeolocationAvailable()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    private func isGeolocationAvailable() -> UIViewController {
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse ||
            status == .authorizedAlways {
            return ModelBuilder.createMonsterMapModule()
        } else {
            return ModelBuilder.createGeolocationRequestModule()
        }
    }
}


