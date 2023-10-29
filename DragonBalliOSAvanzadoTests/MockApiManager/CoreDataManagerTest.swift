//
//  CoreDataManagerTest.swift
//  DragonBalliOSAvanzadoTests
//
//  Created by Manuel Cazalla Colmenero on 29/10/23.
//

import XCTest
@testable import DragonBalliOSAvanzado
import CoreData

class CoreDataManagerTest: XCTestCase {
    private var coreDataManager: CoreDataManager!
    private var  moc: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager()
        moc = coreDataManager.moc
    }
    
    
    override func tearDown() {
        coreDataManager.deleteHeroes()
        coreDataManager = nil
        super.tearDown()
       
    }
    func testSaveHero() {
        let heroToSave = Hero(id: "1", name: "Goku", description: "Powerful Saiyan", photo: "goku.jpg", favorite: false)
        coreDataManager.saveHero(hero: heroToSave)
        
        let savedHeroes = coreDataManager.loadHeros()
        XCTAssertTrue(savedHeroes.contains { $0.id == heroToSave.id })
    }
    
    func testLoadHeros() {
        let hero1 = Hero(id: "1", name: "Goku", description: "Powerful Saiyan", photo: "goku.jpg", favorite: false)
        let hero2 = Hero(id: "2", name: "Vegeta", description: "Prince of Saiyans", photo: "vegeta.jpg", favorite: false)
        
        coreDataManager.saveHero(hero: hero1)
        coreDataManager.saveHero(hero: hero2)
        
       let loadedHeroes = coreDataManager.loadHeros()
        
        XCTAssertEqual(loadedHeroes.count, 2)
        XCTAssertTrue(loadedHeroes.contains { $0.id == hero1.id })
        XCTAssertTrue(loadedHeroes.contains { $0.id == hero2.id })
    }

    func testDeleteHeroes() {
            let hero = Hero(id: "2", name: "Vegeta", description: "Prince of Saiyans", photo: "vegeta.jpg", favorite: false)
            coreDataManager.saveHero(hero: hero)
            
            coreDataManager.deleteHeroes()
            let savedHeroes = coreDataManager.loadHeros()
            XCTAssertEqual(savedHeroes.count, 0)
        }
        
        
    }
   






