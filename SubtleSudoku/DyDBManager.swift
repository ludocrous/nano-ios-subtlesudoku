//
//  ChallengeManager.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 26/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import Foundation
import AWSDynamoDB




class DyDBManager {
    static let sharedInstance = DyDBManager()
    
    var puzzles: [DyDBPuzzle]
    
    
    private init() {  // private init protects singleton pattern.
        puzzles = [DyDBPuzzle]()
    }
    
    func loadSudokuPuzzles (completionHandler: (success: Bool, errorString: String?) -> Void) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        puzzles.removeAll()
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.exclusiveStartKey = nil
        queryExpression.limit = AWSConstants.PageLimit
        dynamoDBObjectMapper .scan(DyDBPuzzle.self, expression: queryExpression) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                if (task.result != nil) {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    for item in paginatedOutput.items as! [DyDBPuzzle]{
                        self.puzzles.append(item)
                    }
                    self.puzzles.sortInPlace({$0.puzzleId < $1.puzzleId})
                    completionHandler(success: true, errorString: nil)
                } else {
                    err("AWS DB query is returning a nil result")
                    completionHandler(success: false, errorString: "No results returned")
                }
            } else {
                err("Error: \(task.error)")
                if let error = task.error {
                    switch error.code {
                    case -1001:
                        completionHandler(success: false, errorString: "Request timed out")
                    case -1009:
                        completionHandler(success: false, errorString: "No internet connection found")
                    default:
                        completionHandler(success: false, errorString: error.localizedDescription)
                    }
                    err("Error code is: \(error.code) and error desc: \(error.localizedDescription)")
                } else { //Generic Error Handler
                    completionHandler(success: false, errorString: "An unknown error has occurred")
                }
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            return nil
        })
    }
    
    
}




/*
func loadSudokuChallenges() {
    
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
    
    dynamoDBObjectMapper .load(DyDBChallenge.self, hashKey: 1, rangeKey: nil) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
        if (task.error == nil) {
            if (task.result != nil) {
                let sd = task.result as! DyDBChallenge
                print("Loaded solution #\(sd.ChallengeId) with problem \(sd.ProblemString!)\nand solution \(sd.SolutionString!)")
//                self.result = (sd.ProblemString!,sd.SolutionString!)
            }
        } else {
            print("Error: \(task.error)")
            let alertController = UIAlertController(title: "Failed to get item from table.", message: task.error!.description, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action:UIAlertAction) -> Void in
            })
            alertController.addAction(okAction)
//            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
        return nil
    })
}
*/