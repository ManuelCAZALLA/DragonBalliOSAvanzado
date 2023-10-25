//
//  HeroLocation.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 24/10/23.
//

import Foundation

typealias HeroLocations = [HeroLocation]

struct HeroLocation: Codable {
    let id: String?
    let latitud: String?
    let longitud: String?
    let dateShow: String?
    let hero: Hero?
}
