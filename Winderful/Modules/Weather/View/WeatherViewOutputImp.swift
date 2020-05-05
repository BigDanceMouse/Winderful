//
//  WeatherViewOutputImp.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import UIKit

class WeatherViewOutputImp: WeatherViewOutput {
    
    func updateWeatherIcon(_ icon: WeatherIcon) {
        // do some another stuff
    }
    
    func updateWindSpeed(_ speed: Int) {
        DispatchQueue.main.async {
            UIApplication.shared.applicationIconBadgeNumber = speed
        }
    }
}
