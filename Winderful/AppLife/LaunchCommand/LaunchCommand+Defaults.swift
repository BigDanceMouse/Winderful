//
//  LaunchCommand+Defaults.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

/// Default launch commands, used in main target
func DefaultLaunchCommands() -> [LaunchCommand] {
    [
        RunWeatherModule(),
        RunBackgroundRefresh(),
        RunAudioTrick(),
        RequestAuthorizations(),
        SetupURLHandlerStrategies()
    ]
}
