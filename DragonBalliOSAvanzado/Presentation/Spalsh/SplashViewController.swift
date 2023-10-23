//
//  SpalshViewController.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 22/10/23.
//

import UIKit
// MARK: - Protocol
protocol SplashViewStateDelegate {
    var viewState: ((SplashViewState) -> Void)? {get set}
    var loginViewModel: LoginViewControllerDelegate { get }
    var heroesViewModel: HeroesViewControllerDelegate { get }
    
    func sendToObserver()
}
enum SplashViewState {
    case loading(_ isloading: Bool)
    case toLogin
    case toHeroes
}
// MARK: - Class
class SplashViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var loadingView: UIView!
    
    var splashViewModel: SplashViewStateDelegate?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Observer()
        splashViewModel?.sendToObserver()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Splash_To_Login":
            guard let loginViewController = segue.destination as? LoginViewController else { return }
            loginViewController.loginViewModel = splashViewModel?.loginViewModel
            
        case "Splash_To_Heroes":
            guard let heroesViewController = segue.destination as? HeroesViewController else { return }
            heroesViewController.heroesViewModel = splashViewModel?.heroesViewModel
            
        default:
            break
        }
    }
    
    private func Observer() {
        splashViewModel?.viewState = { [weak self] state in
            
            DispatchQueue.main.async {
                switch state {
                case .loading( let isLoading):
                    self?.loadingView.isHidden = !isLoading
                    
                case .toLogin:
                    self?.performSegue(withIdentifier: "Splash_To_Login", sender: nil)
                    
                case .toHeroes:
                    self?.performSegue(withIdentifier: "Splash_To_Heroes", sender: nil)
                    
                }
            }
        }
    }
}


