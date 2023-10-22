//
//  HeroesViewModel.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 20/10/23.
//

import Foundation

class HeroesViewModel: HeroesViewControllerDelegate {
    // MARK: - Dependencies
    private let apiManager: ApiManagerProtocol
    private let keychainManager: KeychainManagerProtocol
    
    // MARK: - Properties
    var viewState: ((HeroesViewState) -> Void)?
    var heroesCount: Int {
        heroes.count
    }
   
    private var heroes: Heroes = []
    // MARK: Inits
    init(apiManager: ApiManagerProtocol, keychainManager: KeychainManagerProtocol) {
        self.apiManager = apiManager
        self.keychainManager = keychainManager
        
    }
    
    func sendToObserver() {
        viewState?(.loading(true))
        
        DispatchQueue.global().async {
            defer {self.viewState?(.loading(false))}
            guard let token = self.keychainManager.getToken() else { return}
           
            self.apiManager.getHeroes(by: nil,
                  token: token) { result in
                switch result{
                
                case .success(let heroes):
                    self.heroes = heroes
                    print(heroes)
                    self.viewState?(.updateData)
                   
                case .failure(let error):
                    print("\(error)")
                }
                
               
            
            }
        }
        
    }
    
    func findHero(index: Int) -> Hero? {
        if index >= 0 && index < heroesCount { // Primero compruebo que existe
                    heroes[index]
                }else {
                    nil
                }
            }
    }

