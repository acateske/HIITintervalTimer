//
//  ListOfWorkoutsViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/1/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import RealmSwift

class ListOfWorkoutsViewController: UIViewController {
    
    //MARK:- Setup properties
    
    let realm = try! Realm()
    var selectedRow: Int?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem! {
        didSet {
            doneBarButton.title = "DONE"
            doneBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .normal)
            doneBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.textStyle5], for: .highlighted)
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor.black
        }
    }
    
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var addWorkoutButton: UIButton! {
        didSet {
            addWorkoutButton.isEnabled = false
            addWorkoutButton.isOpaque = true
            addWorkoutButton.setTitle("ADD WORKOUT", for: .normal)
            addWorkoutButton.titleLabel?.font = UIFont.textStyle9
            addWorkoutButton.tintColor = UIColor.black
        }
    }
    
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        title = "WORKOUTS"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 109.0
        load()
        
        if let settingsData = realm.object(ofType: Settings.self, forPrimaryKey: 0) {
            settings = settingsData
        } else {
            print("Not save data yet!!!")
        }
    }
}

//MARK:- Setup DataSource Methods

extension ListOfWorkoutsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutTrainings?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! WorkoutTableViewCell
        cell.backgroundColor = UIColor.black
        cell.selectionStyle = .none
        cell.delegate = self
        if let workout = workoutTrainings?[indexPath.row] {
            cell.trainingNameLabel.text = workout.nameOfTraining
            let timeInterval = workout.totalTime
            let seconds = lroundf(Float(timeInterval))
            let hour = seconds / 3600
            let min = (seconds % 3600) / 60
            let sec = seconds % 60
            let workingTime = String(format: "%02d", hour) + ":" + String(format: "%02d", min) + ":" + String(format: "%02d", sec)
            cell.totalTimeLabel.text = "TOTAL TIME" + " " + workingTime
        }
        return cell
    }
    
    //MARK: Setup handler for load data
    
    func load() {
        workoutTrainings = realm.objects(Workout.self)
        tableView.reloadData()
    }
}

//MARK:- Setup Protocol Methods

extension ListOfWorkoutsViewController: WorkoutTableViewCellDelegate {
    
    func deleteButtonPressed(cell: WorkoutTableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        if let workout = workoutTrainings?[index] {
            do {
                try realm.write {
                    realm.delete(workout)
                }
            } catch {
                print("Error", error.localizedDescription)
            }
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
    
    func editButtonPressed(cell: WorkoutTableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        selectedRow = index
        performSegue(withIdentifier: "goBackToAddAction", sender: self)
    }
}

//MARK:- Setup Delegate Method

extension ListOfWorkoutsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoTrainingVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTrainingVC" {
            if let trainingVC = segue.destination as? TrainingViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    trainingVC.selectedTraining = indexPath.row
                }
            }
        } else if segue.identifier == "goBackToAddAction" {
            if let actionVC = segue.destination as? AddActionViewController {
                actionVC.recivedRow = selectedRow
            }
        }
    }
}
