//
//  ViewController.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 12/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit


//FIXME: REMOVE THIS CODE !!!!!
let probStr1 = "..3.2.6..9..3.5..1..18.64....81.29..7.......8..67.82....26.95..8..2.3..9..5.1.3.."
let soluStr1 = "483921657967345821251876493548132976729564138136798245372689514814253769695417382"
let probStr2 = "4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......"
let soluStr2 = "417369825632158947958724316825437169791586432346912758289643571573291684164875293"

let testSolve = "2...8.3...6..7..84.3.5..2.9...1.54.8.........4.27.6...3.1..7.4.72..4..6...4.1...3"


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //FIXME: Sort out globals for Suduko helper
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func segueToPuzzleList() {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewControllerWithIdentifier("PuzzleTableViewController") as! UITableViewController
        self.presentViewController(resultVC, animated: true, completion: nil)
    
    }

    func segueToChallengeList() {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewControllerWithIdentifier("BaseNavController") as! UINavigationController
        self.presentViewController(resultVC, animated: true, completion: nil)
        
    }
    @IBAction func workAPuzzle(sender: AnyObject) {
        let myGrid = SudoGrid(gridString: testSolve)
        dbg("GS Before: \(myGrid.gridString)")
        myGrid.applyProblemValues()
        dbg("GS After: \(myGrid.gridString)")
        
        myGrid.setValue("A2", entry: 5)
        dbg("GS After: \(myGrid.gridString)")
    }
    
    @IBAction func solveAPuzzle(sender: AnyObject) {
        let myGrid = SudoGrid(gridString: testSolve)
        dbg("GS Before: \(myGrid.gridString)")
        //myGrid.applyProblemValues()
        dbg("GS After: \(myGrid.gridString)")
        
        myGrid.solve()
        if myGrid.solved {
            dbg("Grid is solved - [\(myGrid.gridString)]")
       } else {
            dbg("Grid is NOT solved - [\(myGrid.gridString)]")
        }
//        myGrid.searchSolve()
//        if myGrid.solved {
//            dbg("Grid is solved - [\(myGrid.gridString)]")
//        } else {
//            dbg("Grid is NOT solved - [\(myGrid.gridString)]")
//        }
    }
    

    @IBAction func loadTempChallengeData(sender: AnyObject) {
        let sharedContext = CoreDataStackManager.sharedInstance.managedObjectContext
        
        let entry1 = SudoChallenge(puzzleId: "EASY 0001", problemString: probStr1, solutionString: soluStr1, context: sharedContext)
        let entry2 = SudoChallenge(puzzleId: "EASY 0002", problemString: probStr2, solutionString: soluStr2, context: sharedContext)
        dbg("Entry \(entry1.puzzleId) created with start of \(entry1.dateStarted)")
        dbg("Entry \(entry2.puzzleId) created with start of \(entry2.dateStarted)")
        CoreDataStackManager.sharedInstance.saveContext()
        
    }

   

}

