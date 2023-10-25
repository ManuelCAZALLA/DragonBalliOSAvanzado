//
//  keychainManager.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 16/10/23.
//

import Foundation
import KeychainSwift

// MARK: Protocol
protocol KeychainManagerProtocol {
    func save(token: String)
    func getToken() -> String?
    
}
// MARK: Class
class KeychainManager: KeychainManagerProtocol  {
    private let keychain = KeychainSwift()
    
    private enum ApiKey {
        static let token = "ApiToken"
    }
    
    func save(token: String) {
        keychain.set(token, forKey: ApiKey.token)
    }
    
    func getToken() -> String? {
        keychain.get(ApiKey.token)
    }
    
    func deleteToken() {
        keychain.delete(ApiKey.token)
    }
}
