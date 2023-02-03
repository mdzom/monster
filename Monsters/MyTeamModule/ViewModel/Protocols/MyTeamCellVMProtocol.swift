//
//  MyTeamCellVMProtocol.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 22.01.2023.
//

import Foundation

protocol MyTeamCellVMProtocol: AnyObject {
    var image: String { get }
    var name: String { get }
    var level: String { get }
}
