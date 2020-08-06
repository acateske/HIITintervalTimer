//
//  DataModel.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 8/6/20.
//  Copyright © 2020 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class Workout: Object {
    @objc dynamic var nameOfTraining = ""
    @objc dynamic var numberOfRounds = 0
    @objc dynamic var actionSeconds = 0
    @objc dynamic var restSeconds = 0
    @objc dynamic var totalTime = 0.0
    @objc dynamic var colorAction = ""
    @objc dynamic var colorRest = ""
}

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

struct SettingColor {
    let name: String
    let color: UIColor
}
