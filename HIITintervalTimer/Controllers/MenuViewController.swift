//
//  RootViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/30/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController {

    //MARK:- Set up properties
    
    @IBOutlet weak var homeBtn: UIButton! {
        didSet {
            homeBtn.setTitle("Home", for: .normal)
            homeBtn.tintColor = UIColor.white
            homeBtn.titleLabel?.font = UIFont.textStyle11
        }
    }
    @IBOutlet weak var workoutsBtn: UIButton! {
        didSet {
            workoutsBtn.setTitle("Workouts", for: .normal)
            workoutsBtn.tintColor = UIColor.white
            workoutsBtn.titleLabel?.font = UIFont.textStyle11
        }
    }
    @IBOutlet weak var settingsBtn: UIButton! {
        didSet {
            settingsBtn.setTitle("Settings", for: .normal)
            settingsBtn.tintColor = UIColor.white
            settingsBtn.titleLabel?.font = UIFont.textStyle11
        }
    }
    
    //MARK:- Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        SideMenuManager.defaultManager.menuWidth = view.frame.width/1.3
        
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
        
    }
}
