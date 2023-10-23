//
//  SplashViewModel.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 22/10/23.
//

import Foundation

// MARK: - Protocol


// MARK: - Class
class SplashViewModel: SplashViewStateDelegate {
    private let apiManager: ApiManagerProtocol
    private let keychain: KeychainManagerProtocol
    
    var viewState: ((SplashViewState) -> Void)?
    
    lazy var loginViewModel: LoginViewControllerDelegate = {
        LoginViewModel(apiManager: apiManager, keychain: keychain)
    }()
    
    lazy var heroesViewModel: HeroesViewControllerDelegate = {
        HeroesViewModel(apiManager: apiManager, keychainManager: keychain)
    }()
    
    private func hasToken() -> Bool {
        self.keychain.getToken()?.isEmpty == false
    }
    
    init(apiManager: ApiManagerProtocol, keychain: KeychainManagerProtocol) {
        self.apiManager = apiManager
        self.keychain = keychain
    }
    
     func sendToObserver() {
       viewState?(.loading(true))
       
       DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
           self.hasToken() ? self.viewState?(.toHeroes) : self.viewState?(.toLogin)
               }
           }
}


