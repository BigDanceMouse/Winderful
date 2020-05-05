//
//  WeatherModuleError.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

enum WeatherModuleError: Error {
    case networkTrouble
    case incorrectRequestParameters
    case responseError(Error)
}
