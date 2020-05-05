//
//  RequestAuthorizations.swift
//  Winderful
//
//  Created by Владимир Елизаров on 04.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import UserNotifications

struct RequestAuthorizations: LaunchCommand {
    
    func prepareForLaunch(appManager: ApplicationManager) {
        DispatchQueue.main.async {
            let center = UNUserNotificationCenter.current()
            let completion = RequestAuthorizationCompletion(
                withErrorHandler: appManager.errorHandling)
            center.requestAuthorization(
                options: .badge,
                completionHandler: completion)
        }
    }
}

struct BadgeAccessDeniedError: Error {
    
}
    
private func RequestAuthorizationCompletion(withErrorHandler errorHandler: @escaping (Error) -> Void) -> (Bool, Error?) -> Void {
    { isAuthorized, maybeError in
        if !isAuthorized {
            errorHandler(BadgeAccessDeniedError())
        } else if let error = maybeError {
            errorHandler(error)
        }
    }
}
