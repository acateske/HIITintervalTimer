//
//  ViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 2/19/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import SideMenu

class InitialViewController: UIViewController {

    //MARK: - Set up properties
    
    @IBOutlet weak var addWorkOutButton: UIButton! {
        didSet {
            
            addWorkOutButton.setTitle("ADD WORKOUT", for: .normal)
            addWorkOutButton.tintColor = UIColor.black
            addWorkOutButton.titleLabel?.font = UIFont.textStyle9
        }
    }
    @IBOutlet weak var label: UILabel! {
        didSet {
            
            label.text = "NO WORKOUTS ADDED"
            label.font = UIFont.textStyle4
            label.textColor = UIColor.brownishGrey
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUpNavigationBar()
        SideMenuManager.default.menuFadeStatusBar = false
        
    }
    
    //MARK: - Set up Methods
    
    func setUpNavigationBar() {
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        title = "WORKOUTS"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.textStyle, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func addWorkOutButtonPressed(_ sender: Any) {

        performSegue(withIdentifier: "goToAddActionVC", sender: self)
    }
    
}

