//
//  TrainingViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/10/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    
    //MARK:- Set up Timer properties
    
    var cool = false
    var round = 1
    var seconds = 0
    var timer = Timer()
   // var isTimerRunning = false
    var resumeTapped = false
    
    //MARK:- Set up properties
    
    var selectedTraining: Int?
    var numberOfRounds = 0
    var totalTime = 0.0
    var action = 0
    var rest = 0
    
    
    @IBOutlet weak var totalTimeLabel: UILabel! {
        didSet {
            totalTimeLabel.textAlignment = .center
            totalTimeLabel.textColor = UIColor.white
            totalTimeLabel.font = UIFont.textStyle
            totalTimeLabel.text = "Total Time Left: 00:00:00"
        }
    }
    
    @IBOutlet weak var startWorkingButton: UIButton! {
        didSet {
            startWorkingButton.setImage(UIImage(named: "mediaPlaySymbol"), for: .normal)
        }
    }
    
    @IBOutlet weak var endTimerButton: UIButton! {
        didSet {
            endTimerButton.setTitle("END", for: .normal)
            endTimerButton.titleLabel?.font = UIFont.textStyle
            endTimerButton.tintColor = UIColor.white
        }
    }
    
    @IBOutlet weak var numberOfRoundsLabel: UILabel! {
        didSet {
            numberOfRoundsLabel.textColor = UIColor.white
            numberOfRoundsLabel.textAlignment = .center
            numberOfRoundsLabel.font = UIFont.textStyle
            numberOfRoundsLabel.text = "ROUND 1/1"
        }
    }
    
    @IBOutlet weak var workingTimeLabel: UILabel! {
        didSet {
           // workingTimeLabel.textColor = UIColor.white
            workingTimeLabel.textAlignment = .center
            workingTimeLabel.font = UIFont.textStyle10
            workingTimeLabel.text = "00:00"
        }
    }
    @IBOutlet weak var clapImageView: UIImageView! {
        didSet {
            clapImageView.image = UIImage(named: "clap")
            clapImageView.isHidden = true
        }
    }
    
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.textAlignment = .center
            labelName.textColor = UIColor.white
            labelName.font = UIFont.textStyle2
            labelName.text = "WORKOUT"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        updateView()
    }
    
    func updateView() {
        
        guard let selectedTraining = selectedTraining else {return}
        title = workoutTrainings[selectedTraining].nameOfTraining
        numberOfRounds = workoutTrainings[selectedTraining].numberOfRounds
        numberOfRoundsLabel.text = "ROUND 1/\(numberOfRounds)"
        totalTime = workoutTrainings[selectedTraining].totalTime
        totalTimeLabel.text = timeStringTotalTime(time: TimeInterval(totalTime))
        action = workoutTrainings[selectedTraining].actionSeconds
        rest = workoutTrainings[selectedTraining].restSeconds
        
        if action > 0 && numberOfRounds != 0 {
            seconds = action
            workingTimeLabel.textColor = UIColor.neonYellow
        } else if action == 0 && numberOfRounds != 0 {
            seconds = rest
            cool = true
            workingTimeLabel.textColor = UIColor.neonRed
            labelName.text = "Rest"
        } else if numberOfRounds == 0 {
            seconds = 0
            workingTimeLabel.textColor = UIColor.white
            startWorkingButton.isEnabled = false
        }
        workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
    }
    
    @IBAction func pomocZaSada(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Set up Timer Methods
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        timerWorking()
        timerTotalTime()
    }
    
    func timerWorking() {
        
        if cool {
            if seconds <= 1 && round != numberOfRounds && action > 0 {
                cool = false
                seconds = action
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor.white
                labelName.text = "Workout"
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
                workingTimeLabel.textColor = UIColor.neonYellow
            } else if seconds > 1 {
                seconds -= 1
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
            } else if seconds <= 1 && round != numberOfRounds && action == 0 {
                seconds = rest
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
            } else if seconds <= 1 && round == numberOfRounds {
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
                clapImageView.isHidden = false
                labelName.text = "Finished"
                labelName.textColor = UIColor.neonRed
                workingTimeLabel.text = "00:00"
            }
        } else {
            if seconds <= 1 && rest > 0{
                cool = true
                seconds = rest
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor.neonRed
                labelName.text = "Rest"
            } else if seconds <= 1 && rest == 0 && round != numberOfRounds {
                seconds = action
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
            } else if seconds <= 1 && rest == 0 && round == numberOfRounds {
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
                workingTimeLabel.text = "00:00"
                workingTimeLabel.textColor = UIColor.neonRed
                labelName.text = "Finished"
                clapImageView.isHidden = false
                labelName.textColor = UIColor.neonRed
            } else {
                seconds -= 1
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor.neonYellow
            }
        }
    }
    
    func timerTotalTime() {
        
        if totalTime < 1 {
            timer.invalidate()
        } else {
            totalTime -= 1
            totalTimeLabel.text = timeStringTotalTime(time: TimeInterval(totalTime))
        }
    }
    
    @IBAction func startWorkingPressed(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "mediaPlaySymbol") {
            runTimer()
            startWorkingButton.setImage(UIImage(named: "union1"), for: .normal)
        } else if sender.currentImage == UIImage(named: "union1") {
            timer.invalidate()
            startWorkingButton.setImage(UIImage(named: "mediaPlaySymbol"), for: .normal)
        }
    }
    
    func timeStringTotalTime(time: TimeInterval) -> String {
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return "Total Time Left: " + String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func timeStringWorkingTime(time: TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @IBAction func endTimerPressed(_ sender: UIButton) {
        
        workingTimeLabel.textColor = UIColor.white
        timer.invalidate()
        seconds = 0
        workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
        totalTime = 0
        totalTimeLabel.text = timeStringTotalTime(time: TimeInterval(totalTime))
        labelName.text = "Workout"
        labelName.textColor = UIColor.white
        clapImageView.isHidden = true
        numberOfRoundsLabel.text = "ROUND 1/1"
        startWorkingButton.setImage(UIImage(named: "mediaPlaySymbol"), for: .normal)
        startWorkingButton.isEnabled = false
    }
}
