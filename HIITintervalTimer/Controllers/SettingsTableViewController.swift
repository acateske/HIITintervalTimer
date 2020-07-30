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
        tableView.rowHeight = 94.0
        title = K.Names.settings
        tableView.tableFooterView = UIView()
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        loadSettingsData()
    }
    
// MARK: - TableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.settingsVCCell, for: indexPath) as! SettingsCell
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
        } else if indexPath.row == 3 {
            if settings.sound {
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
    
    private func configureCell(with cell: SettingsCell, indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        cell.settingsButton.tag = indexPath.row
        cell.settingsLabel.text = settingsArray[indexPath.row]
    }
    
    private func configureActiveSettingsBtn(with cell: SettingsCell) {
        cell.settingsButton.setBackgroundImage(UIImage(named: K.ImageNames.yellowView), for: .normal)
        cell.settingsButton.setImage(UIImage(named: K.ImageNames.check), for: .normal)
    }
    
    private func configureInActiveSettingsBtn(with cell: SettingsCell) {
        cell.settingsButton.setBackgroundImage(UIImage(named: K.ImageNames.blackView), for: .normal)
        cell.settingsButton.setImage(UIImage(), for: .normal)
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
        } else {
            do {
                try realm.write {
                    settings.yourPrimaryKey = 0
                    realm.add(settings, update: .all)
                }
            } catch {
                print("Error", error.localizedDescription)
            }
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
            if didCheckKeepScreenOn {
                configureActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.keepScreenOn = didCheckKeepScreenOn
                    }
                } catch {
                    print("Error", error.localizedDescription)
                }
                UIApplication.shared.isIdleTimerDisabled = didCheckKeepScreenOn
            } else {
                configureInActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.keepScreenOn = didCheckKeepScreenOn
                    }
                } catch {
                    print("error",error.localizedDescription)
                }
                UIApplication.shared.isIdleTimerDisabled = didCheckKeepScreenOn
            }
        case 1:
            if didCheckPauseOn {
                configureActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.pauseOn = didCheckPauseOn
                    }
                } catch {
                    print("error",error.localizedDescription)
                }
            } else {
                configureInActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.pauseOn = didCheckPauseOn
                    }
                } catch {
                    print("error", error.localizedDescription)
                }
            }
        case 2:
            if didCheckWormUp {
                configureActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.wormUp = didCheckWormUp
                    }
                } catch {
                    print("error", error.localizedDescription)
                }
            } else {
                configureInActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.wormUp = didCheckWormUp
                    }
                } catch {
                    print("error", error.localizedDescription)
                }
            }
        case 3:
            if didSoundOn {
                configureActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.sound = didSoundOn
                    }
                } catch {
                    print("error", error.localizedDescription)
                }
            } else {
                configureInActiveSettingsBtn(with: cell)
                do {
                    try realm.write {
                        settings.sound = didSoundOn
                    }
                } catch {
                    print("error", error.localizedDescription)
                }
            }
        default:
            break
        }
    }
}
