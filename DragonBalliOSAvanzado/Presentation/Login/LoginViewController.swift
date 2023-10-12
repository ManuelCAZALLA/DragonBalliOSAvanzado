//
//  LoginViewController.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 11/10/23.
//

import UIKit

// MARK: PROTOCOL


// MARK: Class
class LoginViewController: UIViewController {

   // MARK: - IBOutlet
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    // MARK: - IBaction
    @IBAction func loginButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


   
}

// MARK: - EXTENSION
