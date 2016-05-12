//
//  ChallengeTableViewController.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 28/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit
import CoreData

class ChallengeTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem()
        navigationItem.title = "Challenges"
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    
    @IBAction func loadNewChallenge(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PuzzleTableViewController") as! PuzzleTableViewController
        //controller.datasource = SudoChallengeDatasource(challenge: challenges[indexPath.item])
        self.navigationController!.pushViewController(controller, animated: true)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ChallengeManager.sharedInstance.challenges.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let item = ChallengeManager.sharedInstance.challenges[indexPath.row]
        cell.textLabel?.text = "\(item.puzzleId)"
        
        if let myDetailTextLabel = cell.detailTextLabel {
            if item.isSolved {
                myDetailTextLabel.text = "Progress : COMPLETED"
            } else {
                myDetailTextLabel.text = "Progress : \(item.progressPercentage)%"
            }
        }
        
        return cell
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let challenge = ChallengeManager.sharedInstance.challenges[indexPath.row]
            ChallengeManager.sharedInstance.removeChallenge(challenge)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        dbg("Segueing")
        if segue.identifier == "ShowChallenge" {
            let index = tableView.indexPathForCell(sender as! UITableViewCell)?.item
            let challengeDetail = segue.destinationViewController as! ChallengeDetailViewController
            challengeDetail.datasource = SudoChallengeDatasource(challenge: ChallengeManager.sharedInstance.challenges[index!])
        }
        
    }
    
}
