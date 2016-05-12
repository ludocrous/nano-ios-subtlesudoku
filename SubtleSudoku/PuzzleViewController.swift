//
//  PuzzleViewController.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 10/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var unsolvedLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    var puzzleIndex: Int?
    private var puzzle: DyDBPuzzle?
    private var solution: String = ""
    private var puzzleArray: [Character] = [Character]()
    
    override func viewDidLoad() {
        dbg("View Did load called")
        loadData()
        prepareViewLayouts()
        setControls()
    }
    
    @IBAction func acceptChallenge(sender: AnyObject) {
        if let puzzle = puzzle {
            if solution.characters.count == 81 {
                ChallengeManager.sharedInstance.createNewChallenge(puzzle.puzzleId!, problemString: puzzle.problemString!, solutionString: solution)
                self.navigationController?.popToRootViewControllerAnimated(true)
            } else {
                displayAlert("Error", message: "Cannot determine a solution to this puzzle", onViewController: self)
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func prepareViewLayouts() {
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        
        collectionView.frame.size.height = collectionView.frame.size.width
        dbg("Setting size: \(collectionView.frame.size.height)")
        
        let gridWidth = Int(CGRectGetWidth(collectionView!.frame) / 9)
        dbg("Setting grid width: \(gridWidth)")
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: gridWidth, height: gridWidth)
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        detailView.setNeedsLayout()
        detailView.layoutIfNeeded()
    }
    
    func loadData(){
        guard let index = puzzleIndex else {
            err("Set controls index invalid")
            return
        }
        puzzle = DyDBManager.sharedInstance.puzzles[index]
        puzzleArray = puzzle!.puzzleArray
        
        let tempGrid = SudoGrid(gridString: puzzle!.problemString!)
        tempGrid.solve()
        if tempGrid.solved {
            descriptionLabel.text = "PROCESS OF ELIMINATION"
            solution = tempGrid.gridString
        } else {
            tempGrid.searchSolve()
            if tempGrid.solved {
                descriptionLabel.text = "TRAIL AND ERROR"
                solution = tempGrid.gridString
            } else {
                descriptionLabel.text = "UNSOLVABLE"
            }
        }
    }
    
    func setControls() {
        self.navigationItem.title = puzzle!.puzzleId
        if ChallengeManager.sharedInstance.hasChallengeWithId(puzzle!.puzzleId!) {
            descriptionLabel.text = "This challenge has already been accepted"
            acceptButton.enabled = false
        }
    }


    //MARK: - Datasource delegate methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dbg("Calling number of items in sections")
        return SU.numberColumns * SU.numberRows
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PreviewCell", forIndexPath: indexPath) as! PreviewCell
        
        
        if puzzleArray.count > 0 {
            let character = puzzleArray[indexPath.item]
            
            if SU.digitsArray.contains(character) {
                cell.initialize(indexPath.item, value: String(character))
//                cell.previewLabel.text = String(character)
            } else {
                cell.initialize(indexPath.item, value: "")
//                cell.previewLabel.text = ""
            }
            //cell.initialize(indexPath.item, value: cellValue, isOriginal: isOriginal)
            cell.setColors()
            cell.setLabel()
        }
        return cell
    }

}
