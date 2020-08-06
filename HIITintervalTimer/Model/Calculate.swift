//
//  Calculate.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 8/3/20.
//  Copyright © 2020 Aleksandar Tesanovic. All rights reserved.
//

import Foundation


struct CalculateManager {
    
    static func calculateTotalTime(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    static func calculateWorkingTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
