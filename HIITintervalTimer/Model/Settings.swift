//
//  Settings.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 4/3/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import Foundation
import RealmSwift

class Settings: Object {
    
    @objc dynamic var keepScreenOn: Bool = false
    @objc dynamic var pauseOn: Bool = false
    @objc dynamic var wormUp: Bool = false
}

var settings = Settings()
