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
        SideMenuManager.default.menuAnimationFadeStrength = 1
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
}
