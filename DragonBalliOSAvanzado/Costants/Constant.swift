//
//  Constant.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 8/2/24.
//

import Foundation

public enum ApiError: Error {
    case unknow
    case encodingFailed
    case noData
    case malformedUrl
    case decodingFailed
}

public enum ApiConfig {
    static let apiBaseURL = "https://dragonball.keepcoding.education/api"
}
enum EndPoint {
    static let login = "/auth/login"
    static let heroes = "/heros/all"
    static let locations = "/heros/locations"
}
