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

    private let realm = try! Realm()
    private var selectedRow: Int?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem! {
        didSet {
            doneBarButton.title = K.Names.done
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
            addWorkoutButton.setTitle(K.Names.addWorkout, for: .normal)
            addWorkoutButton.titleLabel?.font = UIFont.textStyle9
            addWorkoutButton.tintColor = UIColor.black
        }
    }
    
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        title = K.Names.workouts
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

//MARK:- UITableViewDataSource

extension ListOfWorkoutsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutTrainings?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.listOfWorkoutVcCell, for: indexPath) as! WorkoutwCell
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

//MARK:- UITableViewDelegate Methods

extension ListOfWorkoutsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Seque.trainingVC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Seque.trainingVC {
            if let trainingVC = segue.destination as? TrainingViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    trainingVC.selectedTraining = indexPath.row
                }
            }
        } else if segue.identifier == K.Seque.addActionVC {
            if let actionVC = segue.destination as? AddActionViewController {
                actionVC.recivedRow = selectedRow
            }
        }
    }
}

//MARK:- WorkoutTableViewCellDelegate

extension ListOfWorkoutsViewController: WorkoutCellDelegate {
    
    func deleteButtonPressed(cell: WorkoutwCell) {
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
    
    func editButtonPressed(cell: WorkoutwCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {return}
        selectedRow = index
        performSegue(withIdentifier: K.Seque.addActionVC, sender: self)
    }
}
