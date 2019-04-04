//
//  SettingsTableViewCell.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 4/2/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    //MARK:- Set up Properties
    
    var delegate: DidTapSettingsBtn?
    var didCheckKeepScreenOn: Bool = settings.keepScreenOn
    var didCheckPauseOn = settings.pauseOn
    var didCheckWormUp = settings.wormUp
    
    @IBOutlet weak var settingsLabel: UILabel! {
        didSet {
            settingsLabel.textColor = UIColor.white
            settingsLabel.font = UIFont.textStyle7
        }
    }
    
    @IBOutlet weak var settingsButton: UIButton!
       
    //MARK:- Set up Handlers

    @IBAction func settingsBtnPressed(_ sender: Any) {

        didCheckKeepScreenOn = !didCheckKeepScreenOn
        didCheckPauseOn = !didCheckPauseOn
        didCheckWormUp = !didCheckWormUp
        
        delegate?.didTapSettingsBtn(cell: self, didCheckKeepScreenOn: didCheckKeepScreenOn, didCheckPauseOn: didCheckPauseOn, didCheckWormUp: didCheckWormUp)
    }
}
