//
//  SetupURLHandlerStrategies.swift
//  Winderful
//
//  Created by Владимир Елизаров on 05.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

struct SetupURLHandlerStrategies: LaunchCommand {
    
    func prepareForLaunch(appManager: ApplicationManager) {
        appManager.urlHandlers = [
            CoordinatesStrategy()
        ]
    }
}
