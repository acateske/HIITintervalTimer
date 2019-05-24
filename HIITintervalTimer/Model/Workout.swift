//
//  Workout.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/2/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import Foundation
//import RealmSwift

//class Workout: Object {
//
//    @objc dynamic var nameOfTraining = ""
//    @objc dynamic var numberOfRounds = 0
//    @objc dynamic var actionSeconds = 0
//    @objc dynamic var restSeconds = 0
//    @objc dynamic var totalTime = 0.0
//
//}
//
//var workoutTrainings: Results<Workout>?

class Workout {
    
    var nameOfTraining = ""
    var numberOfRounds = 0
    var actionSeconds = 0
    var restSeconds = 0
    var totalTime = 0.0
    
}

var workoutTrainings = [Workout]()
