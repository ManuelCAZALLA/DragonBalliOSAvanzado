//
//  HeroDao.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 23/10/23.
//

import Foundation
import CoreData

@objc(HeroDao)

class HeroDao: NSManagedObject {
    static let entityName = "HeroDao"
    
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var heroDescription : String?
    @NSManaged var photo: String?
    @NSManaged var favorite:Bool
}
