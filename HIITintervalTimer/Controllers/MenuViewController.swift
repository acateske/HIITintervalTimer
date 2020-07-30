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

    //MARK:- Setup properties
    
    @IBOutlet weak var homeBtn: UIButton! {
        didSet {
            homeBtn.setTitle(K.Names.home, for: .normal)
            homeBtn.tintColor = UIColor.white
            homeBtn.titleLabel?.font = UIFont.textStyle11
        }
    }
    @IBOutlet weak var workoutsBtn: UIButton! {
        didSet {
            workoutsBtn.setTitle(K.Names.workouts, for: .normal)
            workoutsBtn.tintColor = UIColor.white
            workoutsBtn.titleLabel?.font = UIFont.textStyle11
        }
    }
    @IBOutlet weak var settingsBtn: UIButton! {
        didSet {
            settingsBtn.setTitle(K.Names.settings, for: .normal)
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
    
    private func setUpNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }
}
