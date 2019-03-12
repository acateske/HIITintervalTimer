//
//  WorkoutTableViewCell.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/1/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func deleteButtonPressed(cell: WorkoutTableViewCell)
}

class WorkoutTableViewCell: UITableViewCell {
    
    var delegate: CustomCellDelegate?
    
    
    @IBOutlet weak var trainingNameLabel: UILabel! {
        didSet {
            trainingNameLabel.textColor = UIColor.white
            trainingNameLabel.font = UIFont.textStyle7
        }
    }
    
    @IBOutlet weak var totalTimeLabel: UILabel! {
        didSet {
            totalTimeLabel.textColor = UIColor.brownishGrey
            totalTimeLabel.font = UIFont.textStyle6
        }
    }
    
    @IBAction func editTrainingButton(_ sender: Any) {

    }
    
    @IBAction func deleteTrainingButton(_ sender: Any) {
        
        delegate?.deleteButtonPressed(cell: self)
        
    }
}
