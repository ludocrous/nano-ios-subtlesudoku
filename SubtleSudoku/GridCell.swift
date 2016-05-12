//
//  GridCell.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 08/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

let firstBackgroundColor = UIColor.whiteColor()
let secondBackgroundColor = UIColor.lightGrayColor()


// A base class that is used by collection views in both the preview and challenge modes.

class GridCell: UICollectionViewCell {
    
    var currentValue: String = ""
    var index: Int = -1
    var isOriginalValue: Bool = false
    var isCorrect: Bool = false
    var displayCorrectStatus = false
    
    var indexOfCell: Int {
        get {
            return index
        }
        
    }
    
    
    func initialize(index: Int, value: String, isOriginal: Bool = false) {
        self.index = index
        currentValue = value
        isOriginalValue = isOriginal
    }
    
    
    func getTuple(index: Int) -> (result: Int, remainder: Int) {
        assert((0..<81).contains(index), "Not a valid index")
        let result = index / 9
        let remainder = index % 9
        return(result,remainder)
    }
    
    func getBackColor() -> UIColor {
        let (result, remainder) = getTuple(index)
        switch (result, remainder) {
        case (0...2, 3...5) :
            fallthrough
        case (3...5, 0...2):
            fallthrough
        case (3...5, 6...8):
            fallthrough
        case (6...8, 3...5):
            return secondBackgroundColor
        default:
            return firstBackgroundColor
        }
    }
}
