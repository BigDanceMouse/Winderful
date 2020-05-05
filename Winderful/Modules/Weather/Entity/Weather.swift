//
//  Weather.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let windSpeed: Double
    let icon: WeatherIcon
}
