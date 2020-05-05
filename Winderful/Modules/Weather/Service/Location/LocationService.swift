//
//  LocationService.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol LocationService: AnyObject {
    
    /// Stores and returns the currently used location coordinates
    var currentLocation: Coordinates { get set }
}
