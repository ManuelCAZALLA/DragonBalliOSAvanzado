//
//  HeroMap.swift
//  DragonBalliOSAvanzado
//
//  Created by Manuel Cazalla Colmenero on 24/10/24.
//

import UIKit
import MapKit

class HeroMap: NSObject, MKAnnotation {
    var title: String?
    var info: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String? = nil, info: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.info = info
        self.coordinate = coordinate
    }
    
    
}

