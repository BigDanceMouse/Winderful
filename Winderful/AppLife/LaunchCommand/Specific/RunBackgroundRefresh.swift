//
//  RunBackgroundRefresh.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

struct RunBackgroundRefresh: LaunchCommand {
    
    func prepareForLaunch(appManager: ApplicationManager) {
        
        let manager = AppRefreshManager(
            onRefresh: appManager.onWakeUpFromBackground,
            onError: appManager.errorHandling)
        
        appManager.appRefreshManager = manager
    }
}
