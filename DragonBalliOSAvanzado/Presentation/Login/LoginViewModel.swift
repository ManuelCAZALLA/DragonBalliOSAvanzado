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
                    
    
   func loginActionButton(email: String?, password: String?) {
        
        guard validate(email: email) else {
            self.viewState?(.indicateErrorEmail("Email Incorrecto"))
            return
        }
        
        guard validate(password: password ) else {
            self.viewState?(.indicateErrorPassword("Contraseña Erronea"))
            return
        }
        
        logInWith(
            email: email ?? "",
            password: password ?? "")
    }
    
    // MARK: - Private func
    private func validate(email: String?) -> Bool {
        email?.isEmpty == false && email?.contains("@") ?? false
      }
    
    private func validate(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 6
    }
    
    private func logInWith (email: String, password: String) {
        self.viewState?(.nextScreen)
        
    }
}



