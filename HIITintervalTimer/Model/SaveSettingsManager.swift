//
//  SaveSettingsManager.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 8/6/20.
//  Copyright © 2020 Aleksandar Tesanovic. All rights reserved.
//

import UIKit
import RealmSwift

struct SaveSettingsManager {

    static let realm = try! Realm()
    
    static func configureActiveSettingsBtn(with cell: SettingsCell) {
        cell.settingsButton.setBackgroundImage(UIImage(named: K.ImageNames.yellowView), for: .normal)
        cell.settingsButton.setImage(UIImage(named: K.ImageNames.check), for: .normal)
    }
    
    static func configureInActiveSettingsBtn(with cell: SettingsCell) {
        cell.settingsButton.setBackgroundImage(UIImage(named: K.ImageNames.blackView), for: .normal)
        cell.settingsButton.setImage(UIImage(), for: .normal)
    }
    static func createCell(with cell: SettingsCell, didCheckCell: Bool) {
        if didCheckCell {
            configureActiveSettingsBtn(with: cell)
        } else {
            configureInActiveSettingsBtn(with: cell)
        }
    }
    static func saveSettingsScreenOn(_ cell: SettingsCell, check: Bool) {
        createCell(with: cell, didCheckCell: check)
        do {
            try realm.write {
                settings.keepScreenOn = check
            }
        } catch {
            print("Error", error.localizedDescription)
        }
        UIApplication.shared.isIdleTimerDisabled = check
    }
    static func saveSettingsPausedOn(_ cell: SettingsCell, check: Bool) {
        createCell(with: cell, didCheckCell: check)
        do {
            try realm.write {
                settings.pauseOn = check
            }
        } catch {
            print("Error", error.localizedDescription)
        }
    }
    static func saveSettingsWormUp(_ cell: SettingsCell, check: Bool) {
        createCell(with: cell, didCheckCell: check)
        do {
            try realm.write {
                settings.wormUp = check
            }
        } catch {
            print("Error", error.localizedDescription)
        }
    }
    static func saveSettingsSoundOn(_ cell: SettingsCell, check: Bool) {
        createCell(with: cell, didCheckCell: check)
        do {
            try realm.write {
                settings.sound = check
            }
        } catch {
            print("Error", error.localizedDescription)
        }
    }
}
