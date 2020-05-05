//
//  WeatherPresenterImp.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import AVFoundation

class WeatherPresenterImp: WeatherPresenter {
    
    // MARK: - Private properties
    
    private let view: WeatherViewOutput
    
    private let interactor: WeatherInteractor
    
    private var errorOutput: ((Error) -> Void)?
    
    // MARK: - Constructor
    
    init(view: WeatherViewOutput, interactor: WeatherInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - Internal methods
    
    func setErrorOutput(_ output: @escaping (Error) -> Void) {
        errorOutput = output
    }
    
    func runWeatherUpdate() {
        registerTimerAndRunUpdate()
    }
    
    func updateLocation(_ coordinates: Coordinates) {
        interactor.setCurrentLocation(coordinates: coordinates)
        updateWeather()
    }

    // MARK: - Private methods
    
    private func registerTimerAndRunUpdate() {
        updateWeather()
        interactor.runPeriodicalOperation(onFire: { [weak self] in
            self?.updateWeather()
        })
    }
    
    private func updateWeather() {
        interactor.getWeatherForCurrentLocation { [weak self] result in
            self?.handleNewWeatherResponse(result)
        }
    }
    
    private func handleNewWeatherResponse(_ result: Result<Weather, WeatherModuleError>) {
        switch result {
            
        case .success(let weather):
            view.updateWeatherIcon(weather.icon)
            view.updateWindSpeed(Int(weather.windSpeed.rounded()))
            
        case .failure(let error):
            errorOutput?(error)
        }
    }
    
}
