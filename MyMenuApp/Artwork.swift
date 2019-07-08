//
//  Artwork.swift
//  MyMenuApp
//
//  Created by Dung Hong on 4/17/18.
//  Copyright © 2018 Dung Hong. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation {
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(locationName: String, coordinate: CLLocationCoordinate2D) {
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
