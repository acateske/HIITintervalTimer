//
//  SettingsLauncher.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 6/25/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

protocol SettingsLauncherDelegate {
    func changeColor(_ settingsLauncher: SettingsLauncher, with color: UIColor)
}

class SettingsLauncher: NSObject {
   
    //MARK: - Setup properties
    
    var delegate: SettingsLauncherDelegate?
    var tag: Int?
    private let blackView = UIView()
    private let cellID = K.Names.cellID
    private let cellHeight = K.Dimension.cellHeight
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    private let settingColors: [SettingColor] = {
        return [SettingColor(name: K.ColorName.green, color: UIColor.spearmint),
                SettingColor(name: K.ColorName.yellow, color: UIColor.neonYellow),
                SettingColor(name: K.ColorName.red, color: UIColor.neonRed),
                SettingColor(name: K.ColorName.orange, color: UIColor.reddishOrange),
                SettingColor(name: K.ColorName.pink, color: UIColor.purple)]
    }()
    
    //MARK: - Setup handlers
    
     func showSettings(){
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settingColors.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            })
        }
    }
    
    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    //MARK: - Setup Init
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingColorCell.self, forCellWithReuseIdentifier: cellID)
    }
}

//MARK: - UICollectionViewDataSource Methods

extension SettingsLauncher: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingColorCell
        let selectedSettingColor = settingColors[indexPath.item]
        cell.setting = selectedSettingColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout Methods

extension SettingsLauncher: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            let selectedColor = self.settingColors[indexPath.item].color
            if self.tag == 1 {
                self.delegate?.changeColor(self, with: selectedColor)
            } else if self.tag == 2 {
                self.delegate?.changeColor(self, with: selectedColor)
            }
        }
    }
}
