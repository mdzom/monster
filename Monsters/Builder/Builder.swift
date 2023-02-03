//
//  Builder.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 17.01.2023.
//

import UIKit

protocol Builder {
    static func createGeolocationRequestModule() -> UIViewController
    static func createMonsterMapModule() -> UIViewController
    static func createMonsterCaptureModule(_ name: String) -> UIViewController
    static func createMyTeamModule() -> UIViewController
}
