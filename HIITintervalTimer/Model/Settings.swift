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
    
    @objc dynamic var yourPrimaryKey = 0
    @objc dynamic var keepScreenOn: Bool = false
    @objc dynamic var pauseOn: Bool = false
    @objc dynamic var wormUp: Bool = false
    @objc dynamic var sound: Bool = false
    
    override class func primaryKey() -> String {
        return "yourPrimaryKey"
    }
}

var settings = Settings()

