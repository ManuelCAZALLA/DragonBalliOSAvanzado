//
//  HeroesViewModel.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 20/10/23.
//

import Foundation

class HeroesViewModel: HeroesViewControllerDelegate {
    
    var loginViewModel: LoginViewControllerDelegate{
        LoginViewModel(apiManager: apiManager, keychain: keychainManager)
    }
    
    // MARK: - Dependencies
    private let apiManager: ApiManagerProtocol
    private let keychainManager: KeychainManagerProtocol
    private let coreDataManager = CoreDataManager()
    
    // MARK: - Properties
    var viewState: ((HeroesViewState) -> Void)?
    var heroesCount: Int {
        heroes.count
    }
    private var token: String
    
    private var heroes: Heroes = []
    
    // MARK: Inits
    init(apiManager: ApiManagerProtocol, keychainManager: KeychainManagerProtocol, token: String) {
        self.apiManager = apiManager
        self.keychainManager = keychainManager
        self.token = token
        
    }
    
    // MARK: Public Function
    func sendToObserver() {
        print("Cargando superherores de Core Data")
        self.heroes = coreDataManager.loadHeros()
        
        if heroes.isEmpty {
            print("No hay super heroes en Core Data, cargando de la API")
            viewState?(.loading(true))
            
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                
                defer {
                    DispatchQueue.main.async {
                        self.viewState?(.loading(false))
                    }
                }
                
                self.apiManager.getHeroes(by: nil, token: self.token) { result in
                    
                    switch result {
                    case .success(let heroes):
                        self.heroes = heroes
                        let coreDataManager = CoreDataManager()
                        coreDataManager.deleteHeroes()
                        
                        for hero in heroes {
                            coreDataManager.saveHero(hero: hero)
                        }
                        
                        self.viewState?(.updateData)
                        
                    case .failure(let error):
                        print("\(error)")
                    }
                }
                
            }
        }
        
        viewState?(.updateData)
    }
    
    func removeData() {
        keychainManager.deleteToken()
        coreDataManager.deleteHeroes()
    }
    
    func findHero(index: Int) -> Hero? {
        if index >= 0 && index < heroesCount { // Primero compruebo que existe
            heroes[index]
        }else {
            nil
        }
    }
    
    func heroesDetailViewModel(index: Int) -> HeroesDetailViewControllerDelegate? {
        guard let selecHero = findHero(index: index) else { return nil }
        
        return(HeroesDetailViewModel(
            apiManager: apiManager,
            keychain: keychainManager,
            hero: selecHero))
    }
    
    
}

