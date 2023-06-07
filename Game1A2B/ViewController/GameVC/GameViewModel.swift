//
//  GameViewModel.swift
//  Game1A2B
//
//  Created by 李韋辰 on 2023/6/1.
//

import Foundation

class GameViewModel {
    var currentFocusIndex = 0
    var enterNumberArray: [Int] = []
    var indexPath = IndexPath(row: 0, section: 0)
    var answerArray: [Int] = []
    var gameNumberOfPlays = 8
    var isReload = 0
}
