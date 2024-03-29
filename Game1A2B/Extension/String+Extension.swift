//
//  NSString+Extention.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/7.
//

import Foundation

extension String {
    
    init(key: String) {
        self = NSLocalizedString(key, comment: "")
    }
    
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
