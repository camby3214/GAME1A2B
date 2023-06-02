//
//  UIButton+Extention.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/2.
//

import Foundation
import UIKit


extension UIButton {
    static func setNumberBtn(btn: UIButton, title: String) {
        btn.backgroundColor = .black
        btn.tintColor = .white
        btn.layer.borderWidth = 5
        btn.layer.backgroundColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        btn.layer.cornerRadius = 12
        let buttonTitle = NSAttributedString(string: title, attributes: [.font: UIFont.boldSystemFont(ofSize: 40)])
        btn.setAttributedTitle(buttonTitle, for: .normal)
    }
}