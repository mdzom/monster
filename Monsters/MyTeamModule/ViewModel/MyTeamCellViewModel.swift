//
//  MyTeamCellViewModel.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 22.01.2023.
//

import Foundation

final class MyTeamCellViewModel: MyTeamCellVMProtocol {
    
    private var monster: Monster
    
    var image: String {
        monster.name
    }
    
    var name: String {
        monster.name
    }
    
    var level: String {
        monster.level
    }
    
    init(monster: Monster) {
        self.monster = monster
    }
}
