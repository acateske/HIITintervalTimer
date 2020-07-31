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
    
    //MARK:- Setup Properties
    
    var delegate: WorkoutCellDelegate?
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel! 
    
    //MARK:- WorkoutCellDelegate Methods
    
    @IBAction func editTrainingButton(_ sender: Any) {
        delegate?.editButtonPressed(cell: self)
    }
    
    @IBAction func deleteTrainingButton(_ sender: Any) {
        delegate?.deleteButtonPressed(cell: self)
    }
}
