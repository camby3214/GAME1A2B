//
//  UILabel+Extention.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/2.
//

import Foundation
import UIKit

extension UILabel {
    static func setNumLabel(label: UILabel, string: String) {
        label.text = string
        label.font = UIFont.boldSystemFont(ofSize: 24)
    }
}
