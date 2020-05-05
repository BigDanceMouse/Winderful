//
//  AppSleepSuppressor.swift
//  Winderful
//
//  Created by Владимир Елизаров on 03.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol AppSleepSuppressor {
    
    /// Runs the specific task to suppress application from go to suspended mode
    func preventFromSleep()
    
    /// Stops the specific task and enables application go to suspended mode
    func stopSleepSuppression()
}
