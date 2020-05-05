//
//  WeatherView.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol WeatherViewOutput {
    
    /// Shows to user new wind speed value
    func updateWindSpeed(_ speed: Int)
    
    /// Shows to user new weather icon
    func updateWeatherIcon(_ icon: WeatherIcon)
}
