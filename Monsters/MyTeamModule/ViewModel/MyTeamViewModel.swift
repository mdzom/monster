//
//  MyTeamViewModel.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 22.01.2023.
//

import RealmSwift

final class MyTeamViewModel: MyTeamVMProtocol {
    
    private var monsters: Results<Monster> {
        return realm.objects(Monster.self)
    }
    
    func numberOfRows() -> Int {
        monsters.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> MyTeamCellVMProtocol? {
        let monster = monsters[indexPath.row]
        return MyTeamCellViewModel(monster: monster)
    }
}
