//
//  Protocols.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 4/2/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

protocol CustomDeleteDelegate {
    func deleteButtonPressed(cell: WorkoutTableViewCell)
}

protocol CustomEditDelegate {
    func editButtonPressed(cell: WorkoutTableViewCell)
}

protocol DidTapSettingsBtn {
    func didTapSettingsBtn(cell: SettingsTableViewCell, didCheckKeepScreenOn: Bool, didCheckPauseOn: Bool, didCheckWormUp: Bool, didSoundOn: Bool)
}

protocol ChangeColorAction {
    func changeColorAction(with color: UIColor)
}

protocol ChangeColorRest {
    func changeColorRest(with color: UIColor)
}
