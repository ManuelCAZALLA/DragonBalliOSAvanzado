//
//  Hero.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 20/10/23.
//

import Foundation

typealias Heroes = [Hero]

struct Hero: Codable {
    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let favorite: Bool?
}
