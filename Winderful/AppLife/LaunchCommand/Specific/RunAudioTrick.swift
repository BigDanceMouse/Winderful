//
//  RunAudioTrick.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

struct RunAudioTrick: LaunchCommand {
    
    func prepareForLaunch(appManager: ApplicationManager) {
        let backgroundManager = AudioTrickAppSleepSuppressor()
        appManager.backgroundHolder = backgroundManager
        backgroundManager.preventFromSleep()
    }
}
