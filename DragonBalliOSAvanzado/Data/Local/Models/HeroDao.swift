//
//  HeroDao.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 23/10/23.
//

import Foundation
import CoreData

@objc(HeroDAO)

class HeroDAO: NSManagedObject {
    static let entityName = "HeroDAO"
    
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var heroDescription: String?
    @NSManaged var photo: String?
    @NSManaged var favorite: Bool
    
    convenience init(hero: Hero, context: NSManagedObjectContext) {
        self.init(context: context)
        id = hero.id
        name = hero.name
        heroDescription = hero.description
        photo = hero.photo
        favorite = hero.favorite ?? false
    }
}

