//
//  WeatherAssembly.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

class WeatherAssembly {
    
    /// Assembles and returns new instance of whole module
    static func build() -> WeatherModuleInput {
        
        let locationService = LocationServiceImp()
        let networkService = WeatherNetworkServiceImp()
        let prefService = SettingServiceImp()
        
        let interactor = WeatherInteractorImp(
            locationService: locationService,
            networkService: networkService,
            preferenceService:  prefService)
        
        let view = WeatherViewOutputImp()
        
        let presenter = WeatherPresenterImp(
            view: view,
            interactor: interactor)
        
        return presenter
    }
}
