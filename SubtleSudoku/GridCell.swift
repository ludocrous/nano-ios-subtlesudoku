//
//  GridCell.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 08/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

let oddColor = UIColor.grayColor()
let evenColor = UIColor.lightGrayColor()

class GridCell: UICollectionViewCell {
    @IBOutlet var optionLabels: [UILabel]!
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    
    private var currentValue: String = ""
    
    var isOriginalValue: Bool = false
    
    func setValue(value: String, isOriginal: Bool = false) {
        isOriginalValue = isOriginal
        valueLabel.text = "\(currentValue)"
        setTextColor()
    }
    
    func setTextColor() {
        if isOriginalValue {
            valueLabel.textColor = UIColor.blackColor()
        } else {
            valueLabel.textColor = UIColor.greenColor()
        }
    }
}
