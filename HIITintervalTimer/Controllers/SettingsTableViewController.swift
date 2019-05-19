//
//  SettingsTableViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/30/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import StoreKit

class SettingsTableViewController: UITableViewController {

    //MARK:- Set up properties
    
    var settingsArray = ["Keep screen on", "Pause on incoming calls", "Preparation time 10 sec", "Rate the app"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = 94.0
        
        title = "Settings"
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
         let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsTableViewCell
        
        cell.delegate = self
        
        if indexPath.row == 0 {
            if settings.keepScreenOn {
                configureActiveSettingsBtn(with: cell)
            } else {
                configureInActiveSettingsBtn(with: cell)
            }
            configureCell(with: cell, indexPath: indexPath)
            return cell
        } else if indexPath.row == 1 {
            if settings.pauseOn {
                configureActiveSettingsBtn(with: cell)
            } else {
                configureInActiveSettingsBtn(with: cell)
            }
            configureCell(with: cell, indexPath: indexPath)
            return cell
            
        } else if indexPath.row == 2 {
            if settings.wormUp {
                configureActiveSettingsBtn(with: cell)
            } else {
                configureInActiveSettingsBtn(with: cell)
            }
            configureCell(with: cell, indexPath: indexPath)
            return cell
        } else {
            configureCell(with: cell, indexPath: indexPath)
            cell.settingsButton.isHidden = true
            return cell
        }
    }
    
    func configureCell(with cell: SettingsTableViewCell, indexPath: IndexPath) {
        
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.settingsButton.tag = indexPath.row
        cell.settingsLabel.text = settingsArray[indexPath.row]
    }
    
    func configureActiveSettingsBtn(with cell: SettingsTableViewCell) {
        
        cell.settingsButton.setBackgroundImage(UIImage(named: "rectangle65"), for: .normal)
        cell.settingsButton.setImage(UIImage(named: "check"), for: .normal)
    }
    
    func configureInActiveSettingsBtn(with cell: SettingsTableViewCell) {
        
        cell.settingsButton.setBackgroundImage(UIImage(named: "rectangle68"), for: .normal)
        cell.settingsButton.setImage(UIImage(), for: .normal)
    }
    
    //MARK: Rate The App
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if indexPath.row == settingsArray.count - 1 {
            SKStoreReviewController.requestReview()
        }
    }
}

//MARK:- Set up Protocols

extension SettingsTableViewController: DidTapSettingsBtn {
    
    func didTapSettingsBtn(cell: SettingsTableViewCell, didCheckKeepScreenOn: Bool, didCheckPauseOn: Bool, didCheckWormUp: Bool) {
        
        let cellTag = cell.settingsButton.tag
        
        if cellTag == 0 {
            if didCheckKeepScreenOn {
                configureActiveSettingsBtn(with: cell)
                settings.keepScreenOn = didCheckKeepScreenOn
                UIApplication.shared.isIdleTimerDisabled = settings.keepScreenOn
            } else {
                configureInActiveSettingsBtn(with: cell)
                settings.keepScreenOn = didCheckKeepScreenOn
                UIApplication.shared.isIdleTimerDisabled = settings.keepScreenOn
            }
        } else if cellTag == 1 {
            if didCheckPauseOn {
                configureActiveSettingsBtn(with: cell)
                settings.pauseOn = didCheckPauseOn
            } else {
                configureInActiveSettingsBtn(with: cell)
                settings.pauseOn = didCheckPauseOn
            }
        } else if cellTag == 2 {
            if didCheckWormUp {
                configureActiveSettingsBtn(with: cell)
                settings.wormUp = didCheckWormUp
            } else {
                configureInActiveSettingsBtn(with: cell)
                settings.wormUp = didCheckWormUp
            }
        } else {
            print("Nothing to show")
        }
    }
}
