//
//  SettingsService .swift
//  Winderful
//
//  Created by Владимир Елизаров on 19.05.2020.
//  Copyright © 2020 Владимир Елизаров. All rights reserved.
//

import Foundation

struct SettingServiceImp: SettingsService {
    
    var userSystem: SystemOfUnits {
        Locale.current.usesMetricSystem ? .metric : .imperial
    }
}
