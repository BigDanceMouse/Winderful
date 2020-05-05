//
//  AppDelegate.swift
//  Winderful
//
//  Created by Владимир Елизаров on 03.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appManager: ApplicationManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let manager = ApplicationManager()
        self.appManager = manager
        return manager.launchApp(commands: DefaultLaunchCommands())
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        let backgroundTaskId = application.beginBackgroundTask(expirationHandler: nil)
        appManager?.onEnterBackground()
        application.endBackgroundTask(backgroundTaskId)
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        appManager?.handleURL(url) ?? false
    }
}

