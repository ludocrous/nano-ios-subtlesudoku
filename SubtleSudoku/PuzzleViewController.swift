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
    
    @IBAction func acceptChallenge(sender: AnyObject) {
        if let puzzle = puzzle {
            ChallengeManager.sharedInstance.createNewChallenge(puzzle.puzzleId!, problemString: puzzle.problemString!, solutionString: puzzle.solutionString!)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var puzzleIndex: Int?
    private var puzzle: DyDBPuzzle?
    private var puzzleArray: [Character] = [Character]()
    
    override func viewDidLoad() {
        dbg("View Did load called")
        loadData()
        prepareViewLayouts()
        setControls()
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
