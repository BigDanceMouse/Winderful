//
//  WeatherInteractor.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol WeatherInteractor {
    
    func runPeriodicalOperation(onFire: @escaping () -> Void)
    
    /// Fetches new weather entity and returns it into the completion closure
    func getWeatherForCurrentLocation(then completion: @escaping (Result<Weather, WeatherModuleError>) -> Void)
    
    /// Updates currently stored location
    func setCurrentLocation(coordinates: Coordinates)
}
