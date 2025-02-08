//
//  Hero.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 20/10/24.
//

import Foundation

public typealias Heroes = [Hero]

public struct Hero: Codable {
   public let id: String?
   public let name: String?
   public let description: String?
   public let photo: String?
   public let favorite: Bool?
}
extension Hero {
    init(heroDAO: HeroDAO) {
        id = heroDAO.id
        name = heroDAO.name
        description = heroDAO.heroDescription
        photo = heroDAO.photo
        favorite = heroDAO.favorite
    }
}

