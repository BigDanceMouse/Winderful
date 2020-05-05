//
//  WeatherInteractorImp.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

class WeatherInteractorImp: WeatherInteractor {
    
    // MARK: - Private constants
    
    private struct Constants {
        static let refreshDelay: TimeInterval = 30 * 60 // half an hour
    }
    
    private let locationService: LocationService
    
    private let networkService: WeatherNetworkService
    
    private let preferenceService: SettingsService
    
    private var timer: Timer?
    
    private var runLoop: RunLoop?
    
    // MARK: - Constructor

    init(locationService: LocationService, networkService: WeatherNetworkService, preferenceService: SettingsService) {
        self.locationService = locationService
        self.networkService = networkService
        self.preferenceService = preferenceService
    }
    
    // MARK: - Internal methods
    
    func getWeatherForCurrentLocation(then completion: @escaping (Result<Weather, WeatherModuleError>) -> Void) {
        let coordinates = locationService.currentLocation
        let system = preferenceService.userSystem
        networkService.requestWeather(
            for: coordinates,
            system: system,
            then: completion)
    }
    
    func setCurrentLocation(coordinates: Coordinates) {
        locationService.currentLocation = coordinates
    }
    
    func runPeriodicalOperation(onFire: @escaping () -> Void) {
        timer?.invalidate()
        timer = nil
        
        let newTimer = Timer(
            timeInterval: Constants.refreshDelay,
            repeats: true,
            block: { _ in onFire() })
        timer = newTimer
        
        if runLoop == nil {
            runLoop = RunLoop.current
        }
        
        runLoop?.add(newTimer, forMode: .default)
        runLoop?.run()
    }
}
