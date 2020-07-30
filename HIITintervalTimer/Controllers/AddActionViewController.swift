//
//  AddActionViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 2/27/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import RealmSwift

class AddActionViewController: UIViewController {

    //MARK: - Setup properties
    
    var recivedRow: Int?
    private var timer: Timer?
    private let realm = try! Realm()
    private var colorForActionBtn = UIColor.neonYellow
    private var colorForRestBtn = UIColor.neonRed
    private let settingsLauncher = SettingsLauncher()
    private var numberOfRounds = 0
    private var numberOfActionSeconds = 0
    private var numberOfRestSeconds = 0
    private var totalTime = 0
        
    @IBOutlet weak var addRoundsBtn: UIButton!
    @IBOutlet weak var reduceRoundBtn: UIButton!
    @IBOutlet weak var addActionSecondsBtn: UIButton!
    @IBOutlet weak var reduceActionSecondsBtn: UIButton!
    @IBOutlet weak var addRestSecondsBtn: UIButton!
    @IBOutlet weak var reduceRestSecondsBtn: UIButton!
    @IBOutlet weak var trainingNameTextField: UITextField! 
    @IBOutlet weak var actionBtnColor: UIButton!
    @IBOutlet weak var restBtnColor: UIButton!
    
    @IBOutlet weak var restLabel: UILabel! {
        didSet {
            restLabel.text = K.Names.startSeconds
            restLabel.textAlignment = .center
            restLabel.font = UIFont.textStyle9
            restLabel.textColor = UIColor.black
        }
    }
    
    @IBOutlet weak var actionLabel: UILabel! {
        didSet {
            actionLabel.text = K.Names.startSeconds
            actionLabel.textAlignment = .center
            actionLabel.font  = UIFont.textStyle9
            actionLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var labelForRounds: UILabel! {
        didSet {
            labelForRounds.text = K.Names.startRounds
            labelForRounds.font = UIFont.textStyle9
            labelForRounds.textColor = UIColor.black
            labelForRounds.textAlignment = .center
        }
    }
    
    @IBOutlet weak var actionNameLabel: UILabel! {
        didSet {
            actionNameLabel.text = K.Names.action
            actionNameLabel.font = UIFont.textStyle7
            actionNameLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var workoutRoundsView: UIView! {
        didSet {
            workoutRoundsView.backgroundColor = UIColor(patternImage: UIImage(named: K.Names.workoutRoundsView) ?? UIImage())
        }
    }
    @IBOutlet weak var workoutNameView: UIView! {
        didSet {
            workoutNameView.backgroundColor = UIColor(patternImage: UIImage(named: K.Names.workoutNameView) ?? UIImage())
        }
    }
    
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.text = K.Names.workoutName
            labelName.font = UIFont.textStyle7
            labelName.textColor = UIColor.white
        }
    }
    
    @IBAction func actionBtnColorPressed(_ sender: UIButton) {
        handlerMoreAction(sender: sender.tag)
    }
    
    @IBAction func restBtnColorPressed(_ sender: UIButton) {
        handlerMoreAction(sender: sender.tag)
    }
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.title = K.Names.saveBtn
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .normal)
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .highlighted)
        }
    }
        
    @IBOutlet weak var addActionButton: UIButton! {
        didSet {
            addActionButton.setTitle(K.Names.titleBtn, for: .normal)
            addActionButton.tintColor = UIColor.black
            addActionButton.titleLabel?.font = UIFont.textStyle9
        }
    }
    
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        title = K.Names.workouts
        trainingNameTextField.delegate = self
        updateView()
    }
    
    //MARK:- Setup Handlers
    
    private func handlerMoreAction(sender tag: Int) {
        settingsLauncher.tag = tag
        settingsLauncher.delegate = self
        settingsLauncher.showSettings()
    }
    
    private func updateView() {
        if recivedRow != nil {
            let workout = workoutTrainings![recivedRow!]
            numberOfRounds = workout.numberOfRounds
            labelForRounds.text = "\(numberOfRounds) ROUNDS"
            trainingNameTextField.text = workout.nameOfTraining
            numberOfActionSeconds = workout.actionSeconds
            actionLabel.text = "\(numberOfActionSeconds) SECONDS"
            numberOfRestSeconds = workout.restSeconds
            restLabel.text = "\(numberOfRestSeconds) SECONDS"
            colorForActionBtn = UIColor(hexString: workout.colorAction)!
            colorForRestBtn = UIColor(hexString: workout.colorRest)!
            actionBtnColor.backgroundColor = colorForActionBtn
            restBtnColor.backgroundColor = colorForRestBtn
            do {
                try realm.write {
                    realm.delete(workout)
                }
            } catch {
                print("Error", error.localizedDescription)
            }
        }
    }
    
    //MARK: - SaveData Methods
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        if trainingNameTextField.text != "" && numberOfRounds != 0 && numberOfActionSeconds != 0 {
            saveAction()
            resetAction()
        }
    }
    
    private func saveAction() {
        let workout = Workout()
        workout.nameOfTraining = trainingNameTextField.text!
        workout.numberOfRounds = numberOfRounds
        workout.actionSeconds = numberOfActionSeconds
        workout.restSeconds = numberOfRestSeconds
        workout.totalTime = Double(numberOfRounds*(numberOfRestSeconds + numberOfActionSeconds))
        workout.colorAction = colorForActionBtn.hexValue()
        workout.colorRest = colorForRestBtn.hexValue()
        do {
            try realm.write {
                realm.add(workout)
            }
        } catch {
            print("Error saving workouts!, \(error)")
        }
    }
    
    private func resetAction() {
        numberOfRounds = 0
        numberOfRestSeconds = 0
        numberOfActionSeconds = 0
        totalTime = 0
        colorForRestBtn = UIColor.neonRed
        colorForActionBtn = UIColor.neonYellow
        actionBtnColor.backgroundColor = colorForActionBtn
        restBtnColor.backgroundColor = colorForRestBtn
        trainingNameTextField.text = ""
        labelForRounds.text = K.Names.startRounds
        actionLabel.text = K.Names.startSeconds
        restLabel.text = K.Names.startSeconds
    }
    //MARK: - Manipulate with seconds
    
    @IBAction func addOrReduceButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            numberOfRounds += 1
            labelForRounds.text = "\(numberOfRounds) ROUNDS"
        case 1:
            numberOfActionSeconds += 5
            actionLabel.text = "\(numberOfActionSeconds) SECONDS"
        case 2:
            numberOfRestSeconds += 5
            restLabel.text = "\(numberOfRestSeconds) SECONDS"
        case 3:
            if numberOfRounds > 0 {
                numberOfRounds -= 1
                labelForRounds.text = "\(numberOfRounds) ROUNDS"
            }
        case 4:
            if numberOfActionSeconds > 0 {
                numberOfActionSeconds -= 5
                actionLabel.text = "\(numberOfActionSeconds) SECONDS"
            }
        case 5:
            if numberOfRestSeconds > 0 {
                numberOfRestSeconds -= 5
                restLabel.text = "\(numberOfRestSeconds) SECONDS"
            }
        default:
            break
        }
    }
}

//MARK:- UITextFieldDelegate Methods

extension AddActionViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        trainingNameTextField.endEditing(true)
        return true
    }
}

//MARK: - SettingsLauncherDelegate Methods

extension AddActionViewController: SettingsLauncherDelegate {
    
    func changeColorAction(_ settingsLauncher: SettingsLauncher, with color: UIColor) {
        colorForActionBtn = color
        actionBtnColor.backgroundColor = colorForActionBtn
    }
    
    func changeColorRest(_ settingsLauncher: SettingsLauncher, with color: UIColor) {
        colorForRestBtn = color
        restBtnColor.backgroundColor = colorForRestBtn
    }
}
