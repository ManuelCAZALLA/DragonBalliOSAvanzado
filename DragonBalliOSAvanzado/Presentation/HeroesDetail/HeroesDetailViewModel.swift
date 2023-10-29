//
//  HeroesDetaisViewModel.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 23/10/23.
//

import Foundation
// MARK: - Class
class HeroesDetailViewModel: HeroesDetailViewControllerDelegate {
    private let apiManager: ApiManagerProtocol
    private let keychain: KeychainManagerProtocol
    private var hero: Hero
    private var heroLocations: HeroLocations = []
    
    var viewState: ((HeroeDetailViewState) -> Void)?
    
    init(apiManager: ApiManagerProtocol, keychain: KeychainManagerProtocol, hero: Hero) {
        self.apiManager = apiManager
        self.keychain = keychain
        self.hero = hero
    }
    
    func sendToObserver() {
        viewState?(.loading(true))
        
        DispatchQueue.global().async {
            defer {self.viewState?(.loading(false))}
            guard let token = self.keychain.getToken() else {
                return
            }
            
            self.apiManager.getLocations(
                by: self.hero.id,
                token: token) { [weak self] result in
                    switch result{
                        
                    case .success(let heroLocations):
                        self?.heroLocations = heroLocations
                        self?.viewState?(.update(
                            hero: self?.hero,
                            locations: heroLocations))
                        
                    case .failure(let error):
                        print("\(error)")
                    }
                }
        }
    }
}
