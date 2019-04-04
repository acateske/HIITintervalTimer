//
//  SettingsTableViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/30/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //MARK:- Set up properties
    
    var keepScreenOn: Bool = false
    var pauseOn: Bool = false
    var wormUp: Bool = false
    
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
}

//MARK:- Set up Protocols

extension SettingsTableViewController: DidTapSettingsBtn {
    
    func didTapSettingsBtn(cell: SettingsTableViewCell, didCheckKeepScreenOn: Bool, didCheckPauseOn: Bool, didCheckWormUp: Bool) {
        
        let cellTag = cell.settingsButton.tag
        
        if cellTag == 0 {
            if didCheckKeepScreenOn {
                methodsActive(with: cellTag)
                configureActiveSettingsBtn(with: cell)
                keepScreenOn = didCheckKeepScreenOn
                settings.keepScreenOn = keepScreenOn
            } else {
                methodsInActive(with: cellTag)
                configureInActiveSettingsBtn(with: cell)
                keepScreenOn = didCheckKeepScreenOn
                settings.keepScreenOn = keepScreenOn
            }
        } else if cellTag == 1 {
            if didCheckPauseOn {
                methodsActive(with: cellTag)
                configureActiveSettingsBtn(with: cell)
                pauseOn = didCheckPauseOn
                settings.pauseOn = pauseOn
            } else {
                methodsInActive(with: cellTag)
                configureInActiveSettingsBtn(with: cell)
                pauseOn = didCheckPauseOn
                settings.pauseOn = pauseOn
            }
        } else if cellTag == 2 {
            if didCheckWormUp {
                methodsActive(with: cellTag)
                configureActiveSettingsBtn(with: cell)
                wormUp = didCheckWormUp
                settings.wormUp = wormUp
            } else {
                methodsInActive(with: cellTag)
                configureInActiveSettingsBtn(with: cell)
                wormUp = didCheckWormUp
                settings.wormUp = wormUp
            }
        } else {
            print("Nothing to show")
        }
    }
    
    func methodsActive(with cellTag: Int) {
        
        switch cellTag {
        case 0:
            UIApplication.shared.isIdleTimerDisabled = true
            print("ole")
        case 1:
            print("Pause on incoming calls")
        case 2:
            print("Preparation time 10 sec")
        case 3:
            print("Rate the app")
        default:
            print("Something get wrong!")
        }
    }
    
    func methodsInActive(with cellTag: Int) {
        
        switch cellTag {
        case 0:
            UIApplication.shared.isIdleTimerDisabled = false
        case 1:
            print("Non Pause")
        case 2:
            print("Start now!")
        case 3:
            print("No rate")
        default:
            print("get wrong!")
        }
    }
}
