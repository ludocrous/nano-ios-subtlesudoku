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
    
    lazy private var grid: SudoGrid = SudoGrid(gridString: self.problemString)
        
    
    
    
    func screenDisplayValue(gridRef: String) -> (value: String, isInitial: Bool) {
        let cellValue = grid.cellValueAtRef(gridRef)
        return (cellValue, (grid.isOriginalCell(gridRef)))
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        dbg("SudoCahllenge - Lower level init called")
    }

    convenience init(puzzleId: String, problemString: String, solutionString: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("SudoChallenge", inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    
        self.puzzleId = puzzleId
        self.problemString = problemString
        self.solutionString = solutionString
        self.dateStarted = NSDate()
        grid = SudoGrid(gridString: problemString)
        dbg("SudoChallenge instance created")
    }
    
    override func prepareForDeletion() {
        super.prepareForDeletion()
        dbg("Prepare for deletion being called")
    }

}