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
    
    var selectedTraining: Int?
    private let realm = try! Realm()
    private var player: AVAudioPlayer?
    private var cool = false
    private var round = 1
    private var seconds = 0
    private var timer = Timer()
    private var timer2 = Timer()
    private var secForWormUp = 10
    private var wormUp = settings.wormUp
    private var soundOn = settings.sound
    private var numberOfRounds = 0
    private var totalTime = 0.0
    private var action = 0
    private var rest = 0
    private var colorForRest = ""
    private var colorForAction = ""
    
    @IBOutlet weak var totalTimeLabel: UILabel! {
        didSet {
            totalTimeLabel.textAlignment = .center
            totalTimeLabel.textColor = UIColor.white
            totalTimeLabel.font = UIFont.textStyle
            totalTimeLabel.text = K.Names.totalTimeLeft
        }
    }
    
    @IBOutlet weak var startWorkingButton: UIButton! {
        didSet {
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        }
    }
    
    @IBOutlet weak var endTimerButton: UIButton! {
        didSet {
            endTimerButton.setTitle(K.Names.endTimerButton, for: .normal)
            endTimerButton.titleLabel?.font = UIFont.textStyle
            endTimerButton.tintColor = UIColor.white
        }
    }
    
    @IBOutlet weak var numberOfRoundsLabel: UILabel! {
        didSet {
            numberOfRoundsLabel.textColor = UIColor.white
            numberOfRoundsLabel.textAlignment = .center
            numberOfRoundsLabel.font = UIFont.textStyle
            numberOfRoundsLabel.text = K.Names.countRound
        }
    }
    
    @IBOutlet weak var workingTimeLabel: UILabel! {
        didSet {
            workingTimeLabel.textAlignment = .center
            workingTimeLabel.font = UIFont.textStyle10
            workingTimeLabel.text = K.Names.startTime
        }
    }
    @IBOutlet weak var clapImageView: UIImageView! {
        didSet {
            clapImageView.image = UIImage(named: K.ImageNames.clapHands)
            clapImageView.isHidden = true
        }
    }
    
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.textAlignment = .center
            labelName.textColor = UIColor.white
            labelName.font = UIFont.textStyle2
            labelName.text = K.Names.workout
        }
    }
    
    //MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        updateView()
        
         NotificationCenter.default.addObserver(self, selector: #selector(appResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc private func appResignActive() {
        if settings.pauseOn {
            timer.invalidate()
            timer2.invalidate()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        }
    }
    
    private func updateView() {
        guard let selectedTraining = selectedTraining else {fatalError()}
        guard let workout = workoutTrainings?[selectedTraining] else {fatalError()}
        title = workout.nameOfTraining
        numberOfRounds = workout.numberOfRounds
        numberOfRoundsLabel.text = "ROUND 1/\(numberOfRounds)"
        totalTime = workout.totalTime
        totalTimeLabel.text = timeStringTotalTime(time: TimeInterval(totalTime))
        action = workout.actionSeconds
        rest = workout.restSeconds
        colorForAction = workout.colorAction
        colorForRest = workout.colorRest
        
        if wormUp {
            seconds = action
            workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(secForWormUp))
            labelName.text = K.Names.wormUp
            workingTimeLabel.textColor = UIColor.white
        } else {
            seconds = action
            workingTimeLabel.textColor = UIColor(hexString: colorForAction)
            workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer2.invalidate()
        timer.invalidate()
    }
    
    //MARK:- Setup AVAudio player
    
    let soundReady = K.Sounds.soundReady
    let soundRest = K.Sounds.soundRest
    let soundFinished = K.Sounds.soundFinished
    
    private func playSound(with sound: String, extensionn: String = K.Sounds.soundExtension, soundOn: Bool) {
        if !soundOn {
            guard let url = Bundle.main.url(forResource: sound, withExtension: extensionn) else { return }
            do {
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
                guard let player = player else { return }
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Setup Timer Methods
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func runTimer2() {
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerForPreparation), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        timerWorking()
        timerTotalTime()
    }
    
    @objc private func timerForPreparation() {
        if secForWormUp <= 1 {
            wormUp = false
            timer2.invalidate()
            workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
            playSound(with: soundReady, soundOn: soundOn)
            runTimer()
            startWorkingButton.setImage(UIImage(named: "union1"), for: .normal)
            workingTimeLabel.textColor = UIColor(hexString: colorForAction)
            labelName.text = K.Names.workout
        } else {
            secForWormUp -= 1
            workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(secForWormUp))
        }
    }
    
    private func timerWorking() {
        if cool {
            if seconds <= 1 && round != numberOfRounds && action > 0 {
                cool = false
                seconds = action
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor.white
                labelName.text = K.Names.workout
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
                workingTimeLabel.textColor = UIColor(hexString: colorForAction)
                playSound(with: soundReady, soundOn: soundOn)
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
                labelName.text = K.Names.finished
                labelName.textColor = UIColor.neonRed
                workingTimeLabel.text = K.Names.startTime
                playSound(with: soundFinished, soundOn: soundOn)
                startWorkingButton.isEnabled = false
            }
        } else {
            if seconds <= 1 && rest > 0{
                cool = true
                seconds = rest
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor(hexString: colorForRest)
                labelName.text = K.Names.rest
                playSound(with: soundRest, soundOn: soundOn)
            } else if seconds <= 1 && rest == 0 && round != numberOfRounds {
                seconds = action
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                round += 1
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
            } else if seconds <= 1 && rest == 0 && round == numberOfRounds {
                numberOfRoundsLabel.text = "ROUND \(round)/\(numberOfRounds)"
                workingTimeLabel.text = K.Names.startTime
                workingTimeLabel.textColor = UIColor(hexString: colorForRest)
                labelName.text = K.Names.finished
                clapImageView.isHidden = false
                labelName.textColor = UIColor.neonRed
            } else {
                seconds -= 1
                workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
                workingTimeLabel.textColor = UIColor(hexString: colorForAction)
            }
        }
    }
    
    private func timerTotalTime() {
        if totalTime < 1 {
            timer.invalidate()
        } else {
            totalTime -= 1
            totalTimeLabel.text = timeStringTotalTime(time: TimeInterval(totalTime))
        }
    }
    
    @IBAction func startWorkingPressed(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: K.ImageNames.play) && !cool && !wormUp {
            playSound(with: soundReady, soundOn: soundOn)
            runTimer()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.start), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.play) && cool {
            playSound(with: soundRest, soundOn: soundOn)
            runTimer()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.start), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.start) && !wormUp  {
            timer.invalidate()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.play) && !cool && wormUp {
            runTimer2()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.start), for: .normal)
        } else if sender.currentImage == UIImage(named: K.ImageNames.start) && !cool && wormUp {
            timer2.invalidate()
            startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        }
    }
    
    private func timeStringTotalTime(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return "Total Time Left: " + String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func timeStringWorkingTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @IBAction func endTimerPressed(_ sender: UIButton) {
        workingTimeLabel.textColor = UIColor.white
        timer.invalidate()
        timer2.invalidate()
        seconds = 0
        workingTimeLabel.text = timeStringWorkingTime(time: TimeInterval(seconds))
        totalTime = 0
        totalTimeLabel.text = timeStringTotalTime(time: TimeInterval(totalTime))
        labelName.text = K.Names.workout
        labelName.textColor = UIColor.white
        clapImageView.isHidden = true
        numberOfRoundsLabel.text = K.Names.countRound
        startWorkingButton.setImage(UIImage(named: K.ImageNames.play), for: .normal)
        startWorkingButton.isEnabled = false
    }
}
