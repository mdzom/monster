//
//  MyTeamVMProtocol.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 22.01.2023.
//

import Foundation

protocol MyTeamVMProtocol: AnyObject {
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> MyTeamCellVMProtocol?
}
