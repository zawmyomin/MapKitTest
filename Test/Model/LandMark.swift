//
//  LandMark.swift
//  Test
//
//  Created by Justin Zaw on 14/07/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import Foundation
import MapKit

struct LandMark {
    
    let placemark :MKPlacemark
    
    var id : UUID{
        return UUID()
    }
    
    var name : String {
        self.placemark.name ?? ""
    }
    
    var title : String {
        self.placemark.title ?? ""
    }
    
    var coordinate : CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
