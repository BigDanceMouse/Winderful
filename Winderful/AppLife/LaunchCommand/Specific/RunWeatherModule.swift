//
//  RunWeatherModule.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

struct RunWeatherModule: LaunchCommand {
    
    func prepareForLaunch(appManager: ApplicationManager) {
        let module = WeatherAssembly.build()
        appManager.weatherModuleInput = module
        DispatchQueue.global().async {
            module.runWeatherUpdate()
        }
    }
}
