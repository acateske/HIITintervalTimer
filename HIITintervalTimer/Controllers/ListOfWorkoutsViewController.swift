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

    private var workoutTrainings: Results<Workout>?
    private var selectedRow: Int?
    private let realm = try! Realm()
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem! {
        didSet {
            doneBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
            doneBarButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .highlighted)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        title = K.Names.workouts
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 109.0
        tableView.backgroundColor = UIColor.black
        loadWorkouts()
        loadSettingsSetUp()
    }
    
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
           self.navigationController?.popToRootViewController(animated: true)
       }
}

//MARK:- UITableViewDataSource

extension ListOfWorkoutsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutTrainings?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.listOfWorkoutVcCell, for: indexPath) as! WorkoutwCell
        cell.delegate = self
        if let workout = workoutTrainings?[indexPath.row] {
            cell.workout = workout
        }
        return cell
    }
    
    //MARK: Setup handler for load data
    
    func loadWorkouts() {
        workoutTrainings = realm.objects(Workout.self)
        tableView.reloadData()
    }
    
    func loadSettingsSetUp() {
        if let settingsData = realm.object(ofType: Settings.self, forPrimaryKey: 0) {
            settings = settingsData
        } else {
            print("Not save data yet!!!")
        }
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
                    trainingVC.selectedTraining = workoutTrainings?[indexPath.row]
                }
            }
        } else if segue.identifier == K.Seque.addActionVC {
            if let actionVC = segue.destination as? AddActionViewController {
                if let row = selectedRow {
                    actionVC.editTraining = workoutTrainings?[row]
                }
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
