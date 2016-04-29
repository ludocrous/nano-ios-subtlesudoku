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
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    init(puzzleId: String, problemString: String, solutionString: String, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("SudoChallenge", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    
        self.puzzleId = puzzleId
        self.problemString = problemString
        self.solutionString = solutionString
        self.dateStarted = NSDate()
        dbg("SudoChallenge instance created")
    }

}