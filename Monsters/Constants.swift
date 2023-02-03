//
//  Constants.swift
//  Monsters
//
//  Created by Gennadij Pleshanov on 14.01.2023.
//

import UIKit

enum Constants {
    enum Strings {
        static var messageStart: String {
            "Для того, чтобы показать Вас и ближайших монстров, разрешите приложению доступ к вашей геопозиции"
        }
        static var messageAccessRequest: String {
            "Ваше местоположение нужно для отображения ближайших к Вам монстров на карте"
        }
        static var messageNoAccess: String {
            "Мы не знаем где Вы находитесь на карте, разрешите нам определить ваше местоположение, это делается в настройках устройства."
        }
        static var title: String {
            "Разрешить приложению «Monsters» доступ к Вашей геопозиции?"
        }
        static var buttonAllow: String {
            "Разрешить"
        }
        static var buttonDoNotAllow: String {
            "Не разрешать"
        }
        static var buttonSettings: String {
            "Перейти к настройкам"
        }
    }
    
    enum Images {
        static var start: UIImage {
            guard let image = UIImage(named: "start") else {
                return UIImage()
            }
            return image
        }
        static var inquiry: UIImage {
            guard let image = UIImage(named: "inquiry") else {
                return UIImage()
            }
            return image
        }
        static var forbidden: UIImage {
            guard let image = UIImage(named: "forbidden") else {
                return UIImage()
            }
            return image
        }
        
        static var myTeam: UIImage {
            guard let image = UIImage(named: "myTeamBackground") else {
                return UIImage()
            }
            return image
        }
    }
}
