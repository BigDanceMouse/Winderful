//
//  WeatherModuleInput.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol WeatherModuleInput {
    
    /// Sets the closure that will be used for output possible errors during the life cycle
    func setErrorOutput(_ output: @escaping (Error) -> Void)
    
    /// Runs all necessary processes to update weather immediately and prepares whole module for the next updates
    func runWeatherUpdate()
    
    /// Stores new location for weather and updates it immediately
    func updateLocation(_ coordinates: Coordinates)
}
