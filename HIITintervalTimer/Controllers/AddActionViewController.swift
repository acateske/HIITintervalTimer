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

    var editTraining: Workout?
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
    @IBOutlet weak var restLabel: UILabel! 
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var labelForRounds: UILabel!
    @IBOutlet weak var actionNameLabel: UILabel!
    @IBOutlet weak var workoutRoundsView: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .highlighted)
        }
    }
        
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = UIColor.black
        title = K.Names.workouts
        trainingNameTextField.delegate = self
        updateView()
    }
    
    //MARK:- Setup Handlers
    
    @IBAction func actionBtnColorPressed(_ sender: UIButton) {
        handlerMoreAction(sender: sender.tag)
        trainingNameTextField.endEditing(true)
    }
    
    private func handlerMoreAction(sender tag: Int) {
        settingsLauncher.tag = tag
        settingsLauncher.delegate = self
        settingsLauncher.showSettings()
    }
    
    private func updateView() {
        if let workout = editTraining {
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
    @IBAction func workoutsButtonPressed(_ sender: UIButton) {
        if editTraining != nil {
            let alert = UIAlertController(title: "Save Training Firts!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: K.Seque.listOfWorkoutsVC, sender: self)
        }
    }
    
    //MARK: - SaveData Methods
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        if trainingNameTextField.text != "" && numberOfRounds != 0 && numberOfActionSeconds != 0 {
            saveAction()
            resetAction()
            trainingNameTextField.endEditing(true)
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
        editTraining = nil
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
    
    func changeColor(_ settingsLauncher: SettingsLauncher, with color: UIColor) {
        if let buttonTag = settingsLauncher.tag {
            if buttonTag == 1 {
                colorForActionBtn = color
                actionBtnColor.backgroundColor = color
            } else {
                colorForRestBtn = color
                restBtnColor.backgroundColor = color
            }
        }
    }
}
