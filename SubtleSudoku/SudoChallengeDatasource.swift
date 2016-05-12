//
//  SudoGridDatasource.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 08/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit


class SudoChallengeDatasource {
    
    private var challenge : SudoChallenge
    
    var numberOfItems: Int {
        return SU.numberColumns * SU.numberRows
    }
    
    func gridRefToIndex(gridRef: String) -> Int {
        if let index = SU.cells.indexOf(gridRef) {
            return index
        } else {
            return -1
        }
    }
    
    func indexToGridRef(index: Int) -> String {
        assert((0..<81).contains(index), "Illegal index \(index)")
        return SU.cells[index]
    }
        
    func getCellDisplayValue(index: Int) -> String {
        let gridRef = indexToGridRef(index)
        return challenge.screenDisplayValue(gridRef)
    }
    
    func isOriginalValue(index: Int) -> Bool {
        let gridRef = indexToGridRef(index)
        return challenge.isOriginalCell(gridRef)
    }
    
    func setUserValue(index: Int, value: Int) {
        challenge.setUserValue(indexToGridRef(index), value: value)
    }

    init(challenge: SudoChallenge) {
        self.challenge = challenge
        self.challenge.setIntialValues()
    }
    
    
}
