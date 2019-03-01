//
//  AddActionViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 2/27/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class AddActionViewController: UIViewController {

    
    //MARK: - Set up propeties
    
    var numberOfRounds = 0
    var actionSeconds = 0
    var restSeconds = 0
    
    @IBOutlet weak var restColorView: UIView! {
        didSet {
            restColorView.backgroundColor = UIColor.neonRed
        }
    }
    
    @IBOutlet weak var actionColorView: UIView! {
        didSet {
            actionColorView.backgroundColor = UIColor.neonYellow
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
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem! {
        didSet {
            saveBarButton.title = "SAVE"
            saveBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .normal)
        }
    }
    
    @IBOutlet weak var addActionButton: UIButton! {
        didSet {
            addActionButton.setTitle("ADD ACTION", for: .normal)
            addActionButton.tintColor = UIColor.black
            addActionButton.titleLabel?.font = UIFont.textStyle9
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        setUpNavigationBar()
    }
    
    //MARK:- Methods
    
    func setUpNavigationBar() {
        
        title = "WORKOUTS"
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addActionButtonPressed(_ sender: Any) {
        
        print("\(numberOfRounds)")
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
        
        actionSeconds += 10
        actionLabel.text = "\(actionSeconds) SECONDS"
    }
    @IBAction func reduceActionSecondsBtn(_ sender: Any) {
        
        if actionSeconds > 0 {
            actionSeconds -= 10
            actionLabel.text = "\(actionSeconds) SECONDS"
        }
    }
    @IBAction func addRestSecondsBtn(_ sender: Any) {
        
        restSeconds += 10
        restLabel.text = "\(restSeconds) SECONDS"
        
    }
    
    @IBAction func reduceRestSecondsBtn(_ sender: Any) {
        
        if restSeconds > 0 {
            restSeconds -= 10
            restLabel.text = "\(restSeconds) SECONDS"
        }
    }
}
