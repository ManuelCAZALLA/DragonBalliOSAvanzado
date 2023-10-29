//
//  ApiManager.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 17/10/23.
//

import Foundation

public enum ApiError: Error {
    case unknow
    case encodingFailed
    case noData
    case malformedUrl
    case decodingFailed
}

// MARK: - Protocol
public protocol ApiManagerProtocol {
    func login(user: String,
               password: String,
               completion:  ((Result<String, ApiError>) -> Void)?)
    func getHeroes(by name: String?,
                   token: String,
                   completion:((Result<Heroes, ApiError>) -> Void)?)
    func getLocations(by idHero: String?, token: String, completion:((Result<HeroLocations, ApiError>) -> Void)?)
}
// MARK: Class
public class ApiManager: ApiManagerProtocol {
   
    private enum ApiConfig {
        static let apiBaseURL = "https://dragonball.keepcoding.education/api"
    }
    enum EndPoint {
        static let login = "/auth/login"
        static let heroes = "/heros/all"
        static let locations = "/heros/locations"
    }
    
    public func login(user: String,
               password: String,
               completion: ((Result<String, ApiError>) -> Void)?){
        
        guard let url = URL(string: "\(ApiConfig.apiBaseURL)\(EndPoint.login)") else {
            completion?(.failure(.malformedUrl))
            return
        }
        
        guard let dataLogin = String(
            format: "%@:%@",
            user, password).data(using: .utf8)?.base64EncodedString() else {
            completion?(.failure(.encodingFailed))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(dataLogin)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion?(.failure(.unknow))
                return
            }
            
            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion?(.failure(.noData))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {
                completion?(.failure(.decodingFailed))
                return
                
            }
          completion?(.success(token))
        }
        task.resume()
    }
    
    public func getHeroes(by name: String?, token: String, completion: ((Result<Heroes, ApiError>) -> Void)?){
        guard let url = URL(string: "\(ApiConfig.apiBaseURL)\(EndPoint.heroes)") else {
            completion?(.failure(.malformedUrl))
            return
        }
        
        let jsonData: [String: Any] = ["name": name ?? ""]
        let jsonParameters = try? JSONSerialization.data(withJSONObject: jsonData)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)",
                            forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = jsonParameters

       let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
               completion?(.failure(.unknow))
                return
            }

            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
               completion?(.failure(.noData))
                return
            }

            guard let heroes = try? JSONDecoder().decode(Heroes.self, from: data) else {
                completion?(.failure(.decodingFailed))
                return
            }

           completion?(.success(heroes))
        }
            task.resume()
    }
    
    public func getLocations(by idHero: String?, token: String, completion:  ((Result<HeroLocations, ApiError>) -> Void)?) {
        guard let url = URL(string: "\(ApiConfig.apiBaseURL)\(EndPoint.locations)") else {
            completion?(.failure(.malformedUrl))
            return
        }
        
        let jsonData: [String: Any] = ["id": idHero ?? ""]
        let jsonParameters = try? JSONSerialization.data(withJSONObject: jsonData)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8",
                            forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)",
                            forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = jsonParameters

       let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
               completion?(.failure(.unknow))
                return
            }

            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
               completion?(.failure(.noData))
               return
            }

            guard let heroesLocation = try? JSONDecoder().decode(HeroLocations.self, from: data) else {
                print("Error heroesLocations ")
                completion?(.failure(.decodingFailed))
                return
            }
           print("API RESPONSE - GET HEROES: \(heroesLocation)")
            completion?(.success(heroesLocation))
        }
            task.resume()
    }
}

    
    

