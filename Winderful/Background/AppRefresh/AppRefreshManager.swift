//
//  AppRefreshManager.swift
//  Winderful
//
//  Created by Владимир Елизаров on 03.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation
import class UIKit.UIApplication
import BackgroundTasks

class AppRefreshManager {
    

    // MARK: - Internal
    
    init(onRefresh: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        self.onRefresh = onRefresh
        self.onError = onError
        self.registerRefreshTasks()
    }
    
    func scheduleNextAppRefresh() {
        let task = BGAppRefreshTaskRequest(identifier: Constants.windSpeedRefreshTaskId)
        task.earliestBeginDate = Date(timeIntervalSinceNow: Constants.refreshDelay)
        do {
            try scheduler.submit(task)
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Private constants
    
    private enum Constants {
        static let windSpeedRefreshTaskId = "com.winderful.speed.refresh"
        static let refreshDelay: TimeInterval = 60 * 60 // 1 hour
    }
    
    
    // MARK: - Private properties
    
    private let onRefresh: () -> Void
    
    private let onError: (Error) -> Void

    private var scheduler: BGTaskScheduler { .shared }

    
    // MARK: - Private methods
    
    private func registerRefreshTasks()     {
        
        scheduler.cancelAllTaskRequests()
        scheduler.register(
            forTaskWithIdentifier: Constants.windSpeedRefreshTaskId,
            using: nil,
            launchHandler: self.refreshWindSpeed(task:))
    }

    private func refreshWindSpeed(task: BGTask) {
        onRefresh()
        scheduleNextAppRefresh()
    }
}
