//
//  WeatherInteractorImp.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

class WeatherInteractorImp: WeatherInteractor {
    
    let locationService: LocationService
    let networkService: WeatherNetworkService

    init(locationService: LocationService, networkService: WeatherNetworkService) {
        self.locationService = locationService
        self.networkService = networkService
    }
    
    func getWeatherForCurrentLocation(then completion: @escaping (Result<Weather, WeatherModuleError>) -> Void) {
        let coordinates = locationService.currentLocation
        networkService.requestWeather(
            for: coordinates,
            then: completion)
    }
    
    func setCurrentLocation(coordinates: Coordinates) {
        locationService.currentLocation = coordinates
    }
}
