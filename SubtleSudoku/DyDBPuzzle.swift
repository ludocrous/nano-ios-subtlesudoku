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
    
    var puzzleArray: [Character] {
        guard let probStr = problemString else {return [Character]() }
        return Array(probStr.characters)
    }
    
    func unsolvedCount() -> Int {
        if let problem = problemString {
            var count = 0
            for item in problem.characters {
                if !SU.digitsArray.contains(item) {
                    count += 1
                }
            }
            return count
        } else {
            return 0
        }
    }
    
    class func dynamoDBTableName() -> String {
        return "SudokuPuzzles"
    }
    
    class func hashKeyAttribute() -> String {
        return "puzzleId"
    }
    
}