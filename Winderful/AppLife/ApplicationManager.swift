//
//  ApplicationManager.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import UIKit

class ApplicationManager {
    
    var urlHandlers: [URLHandlerStrategy] = []
    
    var backgroundHolder: AppSleepSuppressor?
    
    var appRefreshManager: AppRefreshManager?
    
    var weatherModuleInput: WeatherModuleInput? {
        willSet { newValue?.setErrorOutput(errorHandling) }
    }
    
    /// This function uses to provide possibility to
    /// show errors during application life cycle
    var errorHandling: (Error) -> Void {
        { print($0.localizedDescription) }
    }
    
    /// Call this function when application wakes up from sleep cause of one of background tasks
    var onWakeUpFromBackground: () -> Void {
        { [weak self] in
            self?.backgroundHolder?.preventFromSleep()
            self?.weatherModuleInput?.runWeatherUpdate()
        }
    }
    
    
    // MARK: - Methods
    
    func launchApp(commands: [LaunchCommand]) -> Bool {
        
        commands.forEach {
            $0.prepareForLaunch(appManager: self)
        }
        
        return true
    }
    
    func onEnterBackground() {
        appRefreshManager?.scheduleNextAppRefresh()
    }
    
    func handleURL(_ url: URL) -> Bool {
        urlHandlers.contains(where: {
            $0.handle(url: url, appManager: self)
        })
    }
}


