//
//  SudokuChallenge.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 14/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation
import AWSDynamoDB

class SudokuChallenge :AWSDynamoDBObjectModel,AWSDynamoDBModeling  {
    var ChallengeId: NSNumber?
    var ProblemString: String?
    var SolutionString: String?
    
    class func dynamoDBTableName() -> String! {
        return "Sudoku"
    }
    
    class func hashKeyAttribute() -> String! {
        return "ChallengeId"
    }
    
}