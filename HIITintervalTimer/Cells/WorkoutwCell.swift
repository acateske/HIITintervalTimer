//
//  WorkoutTableViewCell.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/1/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

protocol WorkoutCellDelegate {
    func deleteButtonPressed(cell: WorkoutwCell)
    func editButtonPressed(cell: WorkoutwCell)
}

class WorkoutwCell: UITableViewCell {
    
    //MARK: - Properties
    
    var delegate: WorkoutCellDelegate?
    var workout: Workout? {
        didSet {
            trainingNameLabel.text = workout?.nameOfTraining
            if let time = workout?.totalTime {
                totalTimeLabel.text = CalculateManager.calculateTotalTime(time: time)
            }
        }
    }
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel! 
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           selectionStyle = .none
           backgroundColor = .black
       }
    //MARK: - Methods
    
    @IBAction func editTrainingButton(_ sender: Any) {
        delegate?.editButtonPressed(cell: self)
    }
    
    @IBAction func deleteTrainingButton(_ sender: Any) {
        delegate?.deleteButtonPressed(cell: self)
    }
}


