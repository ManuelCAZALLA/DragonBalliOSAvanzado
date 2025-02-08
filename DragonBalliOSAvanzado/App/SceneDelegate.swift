//
//  SceneDelegate.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 11/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController
        let keychain = KeychainManager()
        rootViewController?.splashViewModel = SplashViewModel(
            apiManager:ApiManager(),
            keychain: keychain
        )
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController ?? UIViewController())
        window?.makeKeyAndVisible()
        
        }
}
