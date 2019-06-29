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

    //MARK: - Set up propeties
    
    let realm = try! Realm()
    
    let settingsLauncher = SettingsLauncher()
    
    var recivedRow: Int?
    var numberOfRounds = 0
    var numberOfActionSeconds = 0
    var numberOfRestSeconds = 0
    var totalTime = 0
    
    @IBOutlet weak var trainingNameTextField: UITextField! {
        didSet {
            trainingNameTextField.textColor = UIColor.black
            trainingNameTextField.font = UIFont.textStyle8
        }
    }
    
    @IBOutlet weak var actionBtnColor: UIButton! {
        didSet {
            actionBtnColor.backgroundColor = colorForActionBtn
            actionBtnColor.tag = 1
        }
    }
    
    @IBOutlet weak var restBtnColor: UIButton! {
        didSet {
            restBtnColor.backgroundColor = colorForRestBtn
            restBtnColor.tag = 2
        }
    }
    
    @IBOutlet weak var restLabel: UILabel! {
        didSet {
            restLabel.text = "0 SECONDS"
            restLabel.textAlignment = .center
            restLabel.font = UIFont.textStyle9
            restLabel.textColor = UIColor.black
        }
    }
    
    @IBOutlet weak var actionLabel: UILabel! {
        didSet {
            actionLabel.text = "0 SECONDS"
            actionLabel.textAlignment = .center
            actionLabel.font  = UIFont.textStyle9
            actionLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var labelForRounds: UILabel! {
        didSet {
            labelForRounds.text = "0 ROUNDS"
            labelForRounds.font = UIFont.textStyle9
            labelForRounds.textColor = UIColor.black
            labelForRounds.textAlignment = .center
        }
    }
    
    @IBOutlet weak var actionNameLabel: UILabel! {
        didSet {
            actionNameLabel.text = "ACTION"
            actionNameLabel.font = UIFont.textStyle7
            actionNameLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var workoutRoundsView: UIView! {
        didSet {
            workoutRoundsView.backgroundColor = UIColor(patternImage: UIImage(named: "rectangle31")!)
        }
    }
    @IBOutlet weak var workoutNameView: UIView! {
        didSet {
            workoutNameView.backgroundColor = UIColor(patternImage: UIImage(named: "rectangle7")!)
        }
    }
    
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.text = "WORKOUT NAME"
            labelName.font = UIFont.textStyle7
            labelName.textColor = UIColor.white
        }
    }
    
    @IBAction func actionBtnColorPressed(_ sender: UIButton) {
        
        handlerMoreAction(sender: sender.tag)
    }
    
    @IBAction func restBtnColorPressed(_ sender: UIButton) {
        
        handleMoreRest(sender: sender.tag)
    }
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.title = "SAVE"
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .normal)
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .highlighted)
        }
    }
        
    @IBOutlet weak var addActionButton: UIButton! {
        didSet {
            addActionButton.setTitle("ADD ACTION", for: .normal)
            addActionButton.tintColor = UIColor.black
            addActionButton.titleLabel?.font = UIFont.textStyle9
        }
    }
    
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        title = "WORKOUTS"
        trainingNameTextField.delegate = self
        updateView()
       // print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    //MARK:- Set up Handlers
    
    
    func handlerMoreAction(sender tag: Int) {
        
        settingsLauncher.tag = tag
        settingsLauncher.delegateActionColor = self
        settingsLauncher.showSettings()
    }
    
    func handleMoreRest(sender tag: Int) {
        
        settingsLauncher.tag = tag
        settingsLauncher.delegateRestColor = self
        settingsLauncher.showSettings()
    }
    
    func updateView() {
        
        if recivedRow != nil {
            let workout = workoutTrainings![recivedRow!]
            numberOfRounds = workout.numberOfRounds
            labelForRounds.text = "\(numberOfRounds) ROUNDS"
            trainingNameTextField.text = workout.nameOfTraining
            numberOfActionSeconds = workout.actionSeconds
            actionLabel.text = "\(numberOfActionSeconds) SECONDS"
            numberOfRestSeconds = workout.restSeconds
            restLabel.text = "\(numberOfRestSeconds) SECONDS"
           // colorForActionBtn = workout.colorAction
            
            do {
                try realm.write {
                    realm.delete(workout)
                }
            } catch {
                print("Error", error.localizedDescription)
            }
        }
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
        if trainingNameTextField.text != "" && numberOfRounds != 0 && numberOfActionSeconds != 0 {
            saveAction()
            resetAction()
        }
    }
    
    @IBAction func addActionButtonPressed(_ sender: Any) {
    
        performSegue(withIdentifier: "goToListOfWorkoutsVC", sender: self)
    }
    
    func saveAction() {
        
        let workout = Workout()
        workout.nameOfTraining = trainingNameTextField.text!
        workout.numberOfRounds = numberOfRounds
        workout.actionSeconds = numberOfActionSeconds
        workout.restSeconds = numberOfRestSeconds
        workout.totalTime = Double(numberOfRounds*(numberOfRestSeconds + numberOfActionSeconds))
      //  workout.colorAction = ""
        do {
            try realm.write {
                realm.add(workout)
            }
        } catch {
            print("Error saving workouts!")
        }
    }
    
    func resetAction() {
        
        numberOfRounds = 0
        numberOfRestSeconds = 0
        numberOfActionSeconds = 0
        totalTime = 0
        
        trainingNameTextField.text = ""
        labelForRounds.text = "0 ROUNDS"
        actionLabel.text = "0 SECONDS"
        restLabel.text = "0 SECONDS"
    }
    
    @IBAction func addButtonRounds(_ sender: Any) {
        
        numberOfRounds += 1
        labelForRounds.text = "\(numberOfRounds) ROUNDS"
    }
    
    @IBAction func reduceButtonRounds(_ sender: Any) {
        
        if numberOfRounds > 0 {
            numberOfRounds -= 1
            labelForRounds.text = "\(numberOfRounds) ROUNDS"
        }
    }
    
    @IBAction func addActionSecondsBtn(_ sender: Any) {
        
        numberOfActionSeconds += 1
        actionLabel.text = "\(numberOfActionSeconds) SECONDS"
    }
    @IBAction func reduceActionSecondsBtn(_ sender: Any) {
        
        if numberOfActionSeconds > 0 {
            numberOfActionSeconds -= 1
            actionLabel.text = "\(numberOfActionSeconds) SECONDS"
        }
    }
    @IBAction func addRestSecondsBtn(_ sender: Any) {
        
        numberOfRestSeconds += 1
        restLabel.text = "\(numberOfRestSeconds) SECONDS"
        
    }
    
    @IBAction func reduceRestSecondsBtn(_ sender: Any) {
        
        if numberOfRestSeconds > 0 {
            numberOfRestSeconds -= 1
            restLabel.text = "\(numberOfRestSeconds) SECONDS"
        }
    }
}

//MARK:- Set up TextFieldDelegate Method

extension AddActionViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        trainingNameTextField.resignFirstResponder()
        return true
    }
}

extension AddActionViewController: ChangeColorRest {
    
    func changeColorRest(with color: UIColor) {
        colorForRestBtn = color
        restBtnColor.backgroundColor = colorForRestBtn
    }
}

extension AddActionViewController: ChangeColorAction {
    
    func changeColorAction(with color: UIColor) {
        colorForActionBtn = color
        actionBtnColor.backgroundColor = colorForActionBtn
    }
}
