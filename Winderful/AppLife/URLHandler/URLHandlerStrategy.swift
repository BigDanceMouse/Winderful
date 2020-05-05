//
//  URLHandlerStrategy.swift
//  Winderful
//
//  Created by Владимир Елизаров on 05.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

/// Instances of this protocol used  to handle specific urls, incoming in the app
protocol URLHandlerStrategy {
    
    /// Handles appropriate url if possible
    ///
    /// - Parameters:
    ///   - url: url to handle
    ///   - appManager: instance of app manager, that will be used to execute specific actions
    ///
    /// - Returns:
    ///     - `true` if instance can and did handle the url
    ///     - `false` if the instance not specified for this url
    func handle(url: URL, appManager: ApplicationManager) -> Bool
}
