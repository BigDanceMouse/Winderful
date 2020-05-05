//
//  LocationServiceImp.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import struct CoreGraphics.CGPoint
import struct CoreGraphics.CGFloat

class LocationServiceImp: LocationService {
    
    var currentLocation: Coordinates {
        get { Coordinates(x: latitude, y: longitude) }
        set { latitude = newValue.x; longitude = newValue.y }
    }
    
    @UserDefault("currentLocation.latitude", defaultValue: Tallinn.latitude)
    private var latitude: CGFloat
    
    @UserDefault("currentLocation.longitude", defaultValue: Tallinn.longitude)
    private var longitude: CGFloat
}


private struct Tallinn {
    static let latitude: CGFloat = 59.43696
    static let longitude: CGFloat = 24.75353
}
