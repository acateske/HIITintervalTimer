//
//  Constants.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 4/25/20.
//  Copyright © 2020 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

struct K {
    
    struct Names {
        static let workouts = "WORKOUTS"
        static let workout = "WORKOUT"
        static let cellID = "CellID"
        static let done = "DONE"
        static let totalTimeLeft = "Total Time Left: 00:00:00"
        static let settings = "Settings"
        static let settingsLabel = "Test"
        static let startSeconds = "0 SECONDS"
        static let startRounds = "0 ROUNDS"
        static let action = "ACTION"
        static let workoutName = "WORKOUT NAME"
        static let saveBtn = "SAVE"
        static let titleBtn = "ADD ACTION"
        static let workoutRoundsView = "rectangle31"
        static let workoutNameView = "rectangle7"
        static let addWorkout = "ADD WORKOUT"
        static let endTimerButton = "END"
        static let countRound = "ROUND 1/1"
        static let startTime = "00:00"
        static let wormUp = "Worm up"
        static let finished = "Finished"
        static let rest = "Rest"
        static let home = "Home"
    }
    
    struct ImageNames {
        static let play = "mediaPlaySymbol"
        static let clapHands = "clap"
        static let start = "union1"
        static let check = "check"
        static let yellowView = "rectangle65"
        static let blackView = "rectangle68"
    }
    
    struct Dimension {
        static let cellHeight: CGFloat = 50
    }
    
    struct Sounds {
        static let soundReady = "451270__alivvie__ready"
        static let soundRest = "108889__tim-kahn__rest"
        static let soundFinished = "34943__sir-yaro__finished"
        static let soundExtension = "wav"
    }
    
    struct Seque {
        static let addActionVC = "goToAddActionVC"
        static let listOfWorkoutsVC = "goToListOfWorkoutsVC"
        static let trainingVC = "gotoTrainingVC"
    }
    
    struct  ColorName {
        static let yellow = "YELLOW"
        static let red = "RED"
        static let green = "GREEN"
        static let orange = "ORANGE"
        static let pink = "PINK"
    }
    
    struct CellIdentifier {
        static let listOfWorkoutVcCell = "workoutCell"
        static let settingsVCCell = "settingsCell"
    }
}

