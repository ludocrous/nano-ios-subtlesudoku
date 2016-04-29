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
        queryExpression.limit = 100
        dynamoDBObjectMapper .scan(DyDBPuzzle.self, expression: queryExpression) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if (task.error == nil) {
                if (task.result != nil) {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    for item in paginatedOutput.items as! [DyDBPuzzle]{
                        self.puzzles.append(item)
                    }
                    completionHandler(success: true, errorString: nil)
                }
            } else {
                err("Error: \(task.error)")
                completionHandler(success: false, errorString: task.error?.description)
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