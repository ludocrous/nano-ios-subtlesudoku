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
    
    var challengeName: String {
        return challenge.puzzleId
    }
    
    func getCellDisplayValue(index: Int) -> String {
        let gridRef = SudoChallenge.indexToGridRef(index)
        return challenge.screenDisplayValue(gridRef)
    }
    
    func isOriginalValue(index: Int) -> Bool {
        let gridRef = SudoChallenge.indexToGridRef(index)
        return challenge.isOriginalCell(gridRef)
    }
    
    func solutionForCell(index: Int) -> String {
        return challenge.solutionForCell(index)
    }
    
    func isCellCorrect(index: Int) -> Bool {
        return getCellDisplayValue(index) == solutionForCell(index)
    }
    
    func setUserValue(index: Int, value: Int) {
        challenge.setUserValue(SudoChallenge.indexToGridRef(index), value: value)
    }
    
    func resetChallenge() {
        challenge.reset()
    }
    


    init(challenge: SudoChallenge) {
        self.challenge = challenge
        self.challenge.setIntialValues()
    }
    
    
}
