//
//  HeroLocation.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 24/10/23.
//

import Foundation

public typealias HeroLocations = [HeroLocation]

public struct HeroLocation: Codable {
   public let id: String?
   public let latitud: String?
   public let longitud: String?
   public let dateShow: String?
   public let hero: Hero?
}
