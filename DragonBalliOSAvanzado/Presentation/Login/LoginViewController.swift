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
    
    // MARK: - IBaction
    @IBAction func loginButton(_ sender: Any) {
        loginViewModel?.loginActionButton(
            email: email.text,
            password: password.text)
    }
    
    var loginViewModel: LoginViewControllerDelegate?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        observer()
    }
    private func initView () {
        email.delegate = self
        password.delegate = self
    }
    
    private func observer() {
        loginViewModel?.viewState = { [weak self] state in
            switch state {
            case .loading(_):
                self?.loadingView.isHidden = true
            
            case .indicateErrorEmail(let error):
                self?.emailError.text = error
                self?.emailError.isHidden = false
                
            case .indicateErrorPassword(let error):
                self?.passwordError.text = error
                self?.passwordError.isHidden = false
                
            case .nextScreen:
                self?.loadingView.isHidden = true
            }
          
        }
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




