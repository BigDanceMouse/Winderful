//
//  UserDefaultsWrapper.swift
//  Winderful
//
//  Created by Владимир Елизаров on 03.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            storage.object(forKey: key) as? T ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key)
            storage.synchronize()
        }
    }
    
    
    // MARK: - Init

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    
    // MARK: - Private
    
    private var storage: UserDefaults {
        UserDefaults.standard
    }
}
