//
//  SettingsTableViewController.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 3/30/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import StoreKit
import RealmSwift

class SettingsTableViewController: UITableViewController {

//MARK:- Setup properties
    
    private let realm = try! Realm()
    private var settingsArray = ["Keep screen on", "Pause on incoming calls", "Preparation time 10 sec", "No sound", "Rate the app"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.black
        tableView.rowHeight = K.Dimension.rowHeight
        title = K.Names.settings
        tableView.tableFooterView = UIView()
        loadSettingsData()
    }
    
// MARK: - TableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.settingsVCCell, for: indexPath) as! SettingsCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.settingsButton.tag = indexPath.row
        cell.settingsLabel.text = settingsArray[indexPath.row]
        
        if indexPath.row == 0 {
            if settings.keepScreenOn {
                SaveSettingsManager.configureActiveSettingsBtn(with: cell)
            } else {
                SaveSettingsManager.configureInActiveSettingsBtn(with: cell)
            }
            return cell
        } else if indexPath.row == 1 {
            if settings.pauseOn {
                SaveSettingsManager.configureActiveSettingsBtn(with: cell)
            } else {
                SaveSettingsManager.configureInActiveSettingsBtn(with: cell)
            }
            return cell
            
        } else if indexPath.row == 2 {
            if settings.wormUp {
                SaveSettingsManager.configureActiveSettingsBtn(with: cell)
            } else {
                SaveSettingsManager.configureInActiveSettingsBtn(with: cell)
            }
            return cell
        } else if indexPath.row == 3 {
            if settings.sound {
                SaveSettingsManager.configureActiveSettingsBtn(with: cell)
            } else {
                SaveSettingsManager.configureInActiveSettingsBtn(with: cell)
            }
            return cell
        } else {
            cell.settingsButton.isHidden = true
            return cell
        }
    }
    
//MARK: RateTheApp
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == settingsArray.count - 1 {
            SKStoreReviewController.requestReview()
        }
    }
    
//MARK:- Manipulating Data
    
    private func loadSettingsData() {
        if let settingsData = realm.object(ofType: Settings.self, forPrimaryKey: 0) {
            settings = settingsData
        }
        tableView.reloadData()
    }
}

//MARK:- SettingsTableViewCellDelegate Methods

extension SettingsTableViewController: SettingsCellDelegate {
    
    func didTapSettingsBtn(cell: SettingsCell, didCheckKeepScreenOn: Bool, didCheckPauseOn: Bool, didCheckWormUp: Bool, didSoundOn: Bool) {
        
        let cellTag = cell.settingsButton.tag
        switch cellTag {
        case 0:
            SaveSettingsManager.saveSettingsScreenOn(cell, check: didCheckKeepScreenOn)
        case 1:
            SaveSettingsManager.saveSettingsPausedOn(cell, check: didCheckPauseOn)
        case 2:
            SaveSettingsManager.saveSettingsWormUp(cell, check: didCheckWormUp)
        case 3:
            SaveSettingsManager.saveSettingsSoundOn(cell, check: didSoundOn)
        default:
            break
        }
    }
}

