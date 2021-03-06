//
//  SelectedCell.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 10/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

class SelectedCell : GridCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setTextColor() {
        if isOriginalValue {
            valueLabel.textColor = UIColor.blackColor()
        } else {
            if displayCorrectStatus && !isCorrect {
                valueLabel.textColor = UIColor.redColor()
            } else {
                valueLabel.textColor = UIColor.blueColor()
            }
        }
    }
    
    func setLabel() {
        valueLabel.text = currentValue
    }
    
    func setColors() {
        setTextColor()
        selectedView.backgroundColor = getBackColor()
    }

}
