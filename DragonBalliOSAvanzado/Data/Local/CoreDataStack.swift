//
//  CoreDataStack.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 26/10/24.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    // Singleton
    static let shared: CoreDataStack = .init()
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DragonBalliOSAvanzado")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
