//
//  TrainingViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/10/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class TrainingViewController: UIViewController {
    
    //MARK:- Setup properties
        
    var selectedTraining: Workout?
    private let realm = try! Realm()
    private var actionTimer = Timer()
    private var prepareTimer = Timer()
    
    private var cool = false
    private var round = 1
    private var seconds = 0
    private var secForWormUp = 10
    private var wormUp = settings.wormUp
    private var soundOn = settings.sound
    private var numberOfRounds = 0
    private var totalTime = 0.0
    private var action = 0
    private var rest = 0
    private var colorForRest = ""
    private var colorForAction = ""
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var endTimerButton: UIButton!
    @IBOutlet weak var numberOfRoundsLabel: UILabel!
    @IBOutlet weak var workingTimeLabel: UILabel!
    @IBOutlet weak var startWorkingButton: UIButton! {
        didSet {
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        }
    }
    @IBOutlet weak var clapImageView: UIImageView! {
        didSet {
            clapImageView.image = UIImage(named: K.ImageNames.clapHands)
            clapImageView.isHidden = true
        }
    }
    
    //MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        updateView()
        view.backgroundColor = UIColor.black
         NotificationCenter.default.addObserver(self, selector: #selector(appResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc private func appResignActive() {
        if settings.pauseOn {
            actionTimer.invalidate()
            prepareTimer.invalidate()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        }
    }
    
    private func updateView() {
        if let workout = selectedTraining {
            title = workout.nameOfTraining
            numberOfRounds = workout.numberOfRounds
            numberOfRoundsLabel.text = "ROUND 1/\(numberOfRounds)"
            totalTime = workout.totalTime
            totalTimeLabel.text = "Total Time Left: \(CalculateManager.calculateTotalTime(time: totalTime))"
            action = workout.actionSeconds
            rest = workout.restSeconds
            colorForAction = workout.colorAction
            colorForRest = workout.colorRest
            
            if wormUp {
                seconds = action
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(secForWormUp))
                labelName.text = K.Names.wormUp
                workingTimeLabel.textColor = UIColor.white
            } else {
                seconds = action
                workingTimeLabel.textColor = UIColor(hexString: colorForAction)
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        prepareTimer.invalidate()
        actionTimer.invalidate()
    }
        
    //MARK: Setup Timer Methods
    
    private func runActionTimer() {
        actionTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func runPrepareTimer() {
        prepareTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerForPreparation), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        timerWorking()
        timerTotalTime()
    }
    
    @objc private func timerForPreparation() {
        if secForWormUp <= 1 {
            wormUp = false
            prepareTimer.invalidate()
            workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
            PlaySound.play(with: K.Sounds.soundReady, soundOn: soundOn)
            runActionTimer()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.pause), for: .normal)
            workingTimeLabel.textColor = UIColor(hexString: colorForAction)
            labelName.text = K.Names.workout
        } else {
            secForWormUp -= 1
            workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(secForWormUp))
        }
    }
    
    private func timerWorking() {
        if cool {
            if seconds <= 1 && round != numberOfRounds {
                cool = false
                seconds = action
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor.white
                labelName.text = K.Names.workout
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
                workingTimeLabel.textColor = UIColor(hexString: colorForAction)
                PlaySound.play(with: K.Sounds.soundReady, soundOn: soundOn)
            } else if seconds > 1 {
                seconds -= 1
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
            }
        } else {
            if seconds <= 1 && rest > 0{
                cool = true
                seconds = rest
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor(hexString: colorForRest)
                labelName.text = K.Names.rest
                PlaySound.play(with: K.Sounds.soundRest, soundOn: soundOn)
            } else if seconds <= 1 && rest == 0 && round != numberOfRounds {
                seconds = action
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
            } else if seconds > 1 {
                seconds -= 1
                workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor(hexString: colorForAction)
            }
        }
    }
    
    private func timerTotalTime() {
        if totalTime <= 1 {
            actionTimer.invalidate()
            clapImageView.isHidden = false
            labelName.text = K.Names.finished
            labelName.textColor = UIColor.neonRed
            workingTimeLabel.text = K.Names.startTime
            PlaySound.play(with: K.Sounds.soundFinished, soundOn: soundOn)
            startWorkingButton.isEnabled = false
            totalTimeLabel.text = K.Names.totalTime
        } else {
            totalTime -= 1
            totalTimeLabel.text = "Total Time Left: \(CalculateManager.calculateTotalTime(time: totalTime))"
        }
    }
    
    @IBAction func startWorkingPressed(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: K.ImageNames.play) && !wormUp {
            runActionTimer()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.pause), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.pause) && !wormUp  {
            actionTimer.invalidate()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.play) && wormUp {
            runPrepareTimer()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.pause), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.pause) && wormUp {
            prepareTimer.invalidate()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        }
    }
    
    @IBAction func endTimerPressed(_ sender: UIButton) {
        workingTimeLabel.textColor = UIColor.white
        actionTimer.invalidate()
        prepareTimer.invalidate()
        seconds = 0
        workingTimeLabel.text = CalculateManager.calculateWorkingTime(time: TimeInterval(seconds))
        totalTime = 0
        totalTimeLabel.text = "Total Time Left: \(CalculateManager.calculateTotalTime(time: totalTime))"
        labelName.text = K.Names.workout
        labelName.textColor = UIColor.white
        clapImageView.isHidden = true
        numberOfRoundsLabel.text = K.Names.countRound
        startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        startWorkingButton.isEnabled = false
    }
}
