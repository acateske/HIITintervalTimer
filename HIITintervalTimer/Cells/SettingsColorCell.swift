//
//  SettingsColorCell.swift
//  HIITintervalTimer
//
//  Created by Aleksandar Tesanovic on 6/25/19.
//  Copyright © 2019 Aleksandar Tesanovic. All rights reserved.
//

import UIKit

class SettingColorCell: UICollectionViewCell {
    
    var setting: SettingColor? {
        didSet {
            nameLabel.text = setting?.name
            colorView.backgroundColor = setting?.color
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.textStyle5
        return label
    }()
    
    let colorView: UIView = {
        let view = UIView()
        if let window = UIApplication.shared.keyWindow {
            view.frame = CGRect(x: window.frame.width - 50, y: 10, width: 30, height: 30)
            view.layer.cornerRadius = 15
            view.backgroundColor = UIColor.spearmint
            view.clipsToBounds = true
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(colorView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
