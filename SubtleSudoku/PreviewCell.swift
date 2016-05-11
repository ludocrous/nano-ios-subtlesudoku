//
//  PreviewCell.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 10/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit


class PreviewCell : GridCell {
    
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var previewView: UIView!
    
    func setLabel() {
        previewLabel.text = currentValue
    }
    
    func setColors() {
        previewView.backgroundColor = getBackColor()
    }

}
