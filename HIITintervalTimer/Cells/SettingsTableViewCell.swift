//
//  SettingsTableViewCell.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 4/2/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

protocol SettingsTableViewCellDelegate {
    func didTapSettingsBtn(cell: SettingsTableViewCell, didCheckKeepScreenOn: Bool, didCheckPauseOn: Bool, didCheckWormUp: Bool, didSoundOn: Bool)
}

class SettingsTableViewCell: UITableViewCell {

    //MARK:- Setup Properties
    
    var delegate: SettingsTableViewCellDelegate?
    var didCheckKeepScreenOn = settings.keepScreenOn
    var didCheckPauseOn = settings.pauseOn
    var didCheckWormUp = settings.wormUp
    var didSoundOn = settings.sound
    
    @IBOutlet weak var settingsLabel: UILabel! {
        didSet {
            settingsLabel.textColor = UIColor.white
            settingsLabel.font = UIFont.textStyle7
        }
    }
    
    @IBOutlet weak var settingsButton: UIButton!
       
    //MARK:- Setup Handlers

    @IBAction func settingsBtnPressed(_ sender: Any) {
        didCheckKeepScreenOn = !didCheckKeepScreenOn
        didCheckPauseOn = !didCheckPauseOn
        didCheckWormUp = !didCheckWormUp
        didSoundOn = !didSoundOn
        delegate?.didTapSettingsBtn(cell: self, didCheckKeepScreenOn: didCheckKeepScreenOn, didCheckPauseOn: didCheckPauseOn, didCheckWormUp: didCheckWormUp, didSoundOn: didSoundOn)
    }
}
