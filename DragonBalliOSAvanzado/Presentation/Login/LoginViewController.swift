//
//  LoginViewController.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 11/10/23.
//

import UIKit

// MARK: PROTOCOL
protocol LoginViewControllerDelegate {
    var viewState: ((LoginView) -> Void)? { get set }
    var heroesViewModel: HeroesViewControllerDelegate {get}
    func loginActionButton(email: String?, password: String?)
}

enum LoginView {
    case loading (_ isloding: Bool)
    case indicateErrorEmail (_ error: String)
    case indicateErrorPassword (_ error: String)
    case nextScreen
}

// MARK: Class
class LoginViewController: UIViewController{
    
    // MARK: - IBOutlet
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
   
    var loginViewModel: LoginViewControllerDelegate?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        observer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "LoginToHero",
              let heroesViewController = segue.destination as? HeroesViewController else {
            return
        }
        
        heroesViewController.heroesViewModel = loginViewModel?.heroesViewModel
    }
    
    private func initView () {
        email.delegate = self
        password.delegate = self
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismisskeyboard)
            )
        )
    }
    
    @objc func dismisskeyboard() { // esta funcion es para el selector
        view.endEditing(true) // Oculta el teclado
    }
    
    private func observer() {
        loginViewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async{
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = !isLoading
                    
                case .indicateErrorEmail(let error):
                    self?.emailError.text = error
                    self?.emailError.isHidden = false
                    
                case .indicateErrorPassword(let error):
                    self?.passwordError.text = error
                    self?.passwordError.isHidden = false
                    
                case .nextScreen:
                    self?.performSegue(withIdentifier: "LoginToHero", sender: nil)
                }
            }
        }
    }
    // MARK: - IBaction
    @IBAction func loginButton(_ sender: Any) {
        loginViewModel?.loginActionButton(
            email: email.text,
            password: password.text)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == email {
            emailError.isHidden = true
        }else if textField == password {
            passwordError.isHidden = true
            
        }
    }
}




