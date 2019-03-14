//
//  TrainingViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/10/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {

    
    //MARK:- Set up properties
    
    @IBOutlet weak var totalTimeLabel: UILabel! {
        didSet {
            totalTimeLabel.textAlignment = .center
            totalTimeLabel.textColor = UIColor.white
            totalTimeLabel.font = UIFont.textStyle
            totalTimeLabel.text = "Total Time Left: 00:00:00"
        }
    }
    
    @IBOutlet weak var numberOfRoundsLabel: UILabel! {
        didSet {
            numberOfRoundsLabel.textColor = UIColor.white
            numberOfRoundsLabel.textAlignment = .center
            numberOfRoundsLabel.font = UIFont.textStyle
            numberOfRoundsLabel.text = "ROUND 1/8"
        }
    }
    
    @IBOutlet weak var workingTimeLabel: UILabel! {
        didSet {
            workingTimeLabel.textColor = UIColor.white
            workingTimeLabel.textAlignment = .center
            workingTimeLabel.font = UIFont.textStyle10
            workingTimeLabel.text = "00:00"
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

    }
    

    

}
