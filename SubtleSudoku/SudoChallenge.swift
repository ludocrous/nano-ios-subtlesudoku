//
//  SudoChallenge.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 26/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation
import CoreData

class SudoChallenge : NSManagedObject {
    
    @NSManaged var puzzleId: String
    @NSManaged var problemString: String
    @NSManaged var solutionString: String
    @NSManaged var dateStarted: NSDate
    @NSManaged var userEntryString: String
    
    lazy private var grid: SudoGrid = SudoGrid(gridString: self.problemString)
    
    
    var solutionArray: [String] {
        assert(solutionString.characters.count == 81, "Invalid Solution String")
        var result = [String]()
        for char in solutionString.characters {
            result.append(String(char))
        }
        return result
    }
    
    var challengeString: String {
        return grid.gridString
    }
    
    var isSolved: Bool {
        return challengeString == solutionString
    }
    
    var progressPercentage: Int {
        let given = SU.validCount(problemString)
        let toSolve = 81 - given
        let progress = SU.validCount(grid.userEntryString)
        return Int(Double(progress) / Double(toSolve) * 100)
    }
    
    
    //MARK: Class functions
    
    static func gridRefToIndex(gridRef: String) -> Int {
        if let index = SU.cells.indexOf(gridRef) {
            return index
        } else {
            return -1
        }
    }
    
    static func indexToGridRef(index: Int) -> String {
        assert((0..<81).contains(index), "Illegal index \(index)")
        return SU.cells[index]
    }
    
    
    
    func screenDisplayValue(gridRef: String) -> String {
        let cellValue = grid.cellValueAtRef(gridRef)
        return cellValue
    }

    func isOriginalCell(gridRef: String) -> Bool {
        return (grid.isOriginalCell(gridRef))
    }
    
    func solutionForCell(index:Int) -> String {
        return String(solutionArray[index])
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        dbg("SudoChallenge - Lower level init called")
    }

    convenience init(puzzleId: String, problemString: String, solutionString: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("SudoChallenge", inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    
        self.puzzleId = puzzleId
        self.problemString = problemString
        self.solutionString = solutionString
        self.dateStarted = NSDate()
        grid = SudoGrid(gridString: problemString)
        self.userEntryString = grid.userEntryString
        dbg("SudoChallenge instance created")
    }
    
    override func prepareForDeletion() {
        super.prepareForDeletion()
        dbg("Prepare for deletion being called")
    }
    
    func setUserValue(gridRef: String, value: Int) {
        grid.setValue(gridRef, entry: value)
        userEntryString = grid.userEntryString
        CoreDataStackManager.sharedInstance.saveContext()
    }
    
    func resetState() {
        setIntialValues()
        if userEntryString.characters.count == 81 {
            let progArray = Array(userEntryString.characters)
            for i in 0...80 {
                if SU.digitsArray.contains(progArray[i]) {
                    let value: Int = Int(String(progArray[i]))!
                    grid.setValue(SU.cells[i], entry: value)
                }
            }
        } else {
            err("Progress string should be 81")
        }
    }
    
    func reset() {
        grid = SudoGrid(gridString: problemString)
        setIntialValues()
    }
    
    func setIntialValues () {
        grid.applyProblemValues()
    }
    
 

}