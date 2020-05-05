//
//  WeatherNetworkService.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol WeatherNetworkService {
    
    /// Performs request to endpoint and returns result into the completion closure
    func requestWeather(for location: Coordinates, system: SystemOfUnits, then completion: @escaping (WeatherResult) -> Void)
}
