//
//  LaunchCommand.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

protocol LaunchCommand {
    
    /// Prepares specific parts for launching the application
    func prepareForLaunch(appManager: ApplicationManager)
}
