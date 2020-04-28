//
//  ViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 2/19/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    //MARK: - Setup properties
    
    private var goToAddActionVC = "goToAddActionVC"
    
    @IBOutlet weak var addWorkOutButton: UIButton!
    @IBOutlet weak var label: UILabel! 
    
    //MARk:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUpNavigationBar()
        SideMenuManager.default.menuFadeStatusBar = false
    }
    
    //MARK: - Setup Methods
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        title = Constants.Names.workouts
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.textStyle, NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func addWorkOutButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: goToAddActionVC, sender: self)
    }
}

