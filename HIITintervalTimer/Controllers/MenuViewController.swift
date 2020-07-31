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
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var workoutsBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton! 
    
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
