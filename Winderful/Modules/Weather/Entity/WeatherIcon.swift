//
//  WeatherIcon.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

enum WeatherIcon: String, Decodable {
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain
    case snow
    case sleet
    case wind
    case fog
    case cloudy
}
