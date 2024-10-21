//
//  LiginViewModel.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 11/10/23.
//

import Foundation

// MARK: - Class
class LoginViewModel: LoginViewControllerDelegate {
    var viewState: ((LoginView) -> Void)?
    var heroesViewModel: HeroesViewControllerDelegate {
        HeroesViewModel(apiManager: apiManager, keychainManager: keychain, token: keychain.getToken()!)
    }
    //MARK: - Dependencies
    private let apiManager: ApiManagerProtocol
    private let keychain: KeychainManagerProtocol
    
    //MARK: -Inits
    init( apiManager: ApiManagerProtocol, keychain: KeychainManagerProtocol) {
        self.apiManager = apiManager
        self.keychain = keychain
    }
    
    func loginActionButton(email: String?, password: String?) {
        self.viewState?(.loading(true))
        
        DispatchQueue.global().async{
            guard self.validate(email: email) else {
                self.viewState?(.loading(false))
                self.viewState?(.indicateErrorEmail("Email Incorrecto"))
                return
            }
            
            guard self.validate(password: password ) else {
                self.viewState?(.loading(false))
                self.viewState?(.indicateErrorPassword("Contraseña Erronea"))
                return
            }
            
            self.logInWith(
                email: email ?? "",
                password: password ?? "")
        }
    }
    
    // MARK: - Private func
    private func validate(email: String?) -> Bool {
        email?.isEmpty == false && email?.contains("@") ?? false
    }
    
    private func validate(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 6
    }
    
    private func logInWith (email: String, password: String) {
        apiManager.login(user: email, password: password) { result in
            switch result {
            case .success(let token):
                
                self.keychain.save(token: token)
                self.viewState?(.nextScreen)
                
            case .failure:
                self.viewState?(.indicateErrorEmail("Ocurrió un error durante el inicio de sesión. Por favor, inténtelo de nuevo."))
            }
        }
    }
}







