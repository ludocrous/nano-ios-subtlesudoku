//
//  SudokuChallenge.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 14/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation
import AWSDynamoDB

class DyDBPuzzle :AWSDynamoDBObjectModel,AWSDynamoDBModeling  {
    var puzzleId: String?
    var problemString: String?
    var solutionString: String?
    
    class func dynamoDBTableName() -> String! {
        return "SudokuPuzzles"
    }
    
    class func hashKeyAttribute() -> String! {
        return "puzzleId"
    }
    
}