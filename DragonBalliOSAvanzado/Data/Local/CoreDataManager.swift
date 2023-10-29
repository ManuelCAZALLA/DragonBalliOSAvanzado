//
//  CoreDataManager.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 26/10/23.
//

import UIKit
import CoreData

class CoreDataManager {
    
    public var moc: NSManagedObjectContext {
        CoreDataStack.shared.persistentContainer.viewContext
    }
    
    func saveHero(hero: Hero) {
        let heroToSave = HeroDAO(hero: hero, context: moc)
        try? moc.save()
        
    }
    
    func loadHeros() -> Heroes {
        let fetchRequest = NSFetchRequest<HeroDAO>(entityName: HeroDAO.entityName)
        
        guard let heroes = try? moc.fetch(fetchRequest) else {
            print("Error al cargar los héroes")
            return []
        }
        return heroes.map { heroDao in
            Hero(heroDAO: heroDao)}
    }
    
    func deleteHeroes() {
        let fetchHero = NSFetchRequest<HeroDAO>(entityName: "HeroDAO")
        
        let heroes = try? moc.fetch(fetchHero)
        heroes?.forEach {moc.delete($0)}
        try? moc.save() }
}




