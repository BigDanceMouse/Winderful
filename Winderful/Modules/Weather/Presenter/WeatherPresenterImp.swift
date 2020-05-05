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
    
    
    // MARK: - Internal
    
    init(view: WeatherViewOutput, interactor: WeatherInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func setErrorOutput(_ output: @escaping (Error) -> Void) {
        self.errorOutput = output
    }
    
    func runWeatherUpdate() {
        registerTimerAndRunUpdate()
    }
    
    func updateLocation(_ coordinates: Coordinates) {
        interactor.setCurrentLocation(coordinates: coordinates)
        updateWeather()
    }
    
    
    // MARK: - Private constants
    
    private struct Constants {
        static let refreshDelay: TimeInterval = 30 * 60 // half an hour
    }
    
    
    // MARK: - Private properties
    
    private let view: WeatherViewOutput
    
    private let interactor: WeatherInteractor
    
    private var errorOutput: ((Error) -> Void)?
    
    private var timer: Timer?
    
    private var runLoop: RunLoop?
    
    
    // MARK: - Private methods
    
    private func registerTimerAndRunUpdate() {
        registerTimer()
        updateWeather()
    }
    
    private func registerTimer() {
        timer?.invalidate()
        timer = nil
        
        let newTimer = Timer(
            timeInterval: Constants.refreshDelay,
            repeats: true,
            block: { [weak self] _ in
                self?.updateWeather()
        })
        timer = newTimer
        
        if self.runLoop == nil {
            self.runLoop = RunLoop.current
        }
        
        self.runLoop?.add(newTimer, forMode: .default)
        self.runLoop?.run()
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
