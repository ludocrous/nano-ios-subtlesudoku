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
    
    
//    var challenges = [SudoChallenge]()
    
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = editButtonItem()
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        dbg("Number of secs being called")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        dbg("Number of rows being called")
        return ChallengeManager.sharedInstance.challenges.count
    }
    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return false
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        dbg("cell for row being called")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let item = ChallengeManager.sharedInstance.challenges[indexPath.row]
        cell.textLabel?.text = "Challenge: \(item.puzzleId)"
        
        if let myDetailTextLabel = cell.detailTextLabel {
            myDetailTextLabel.text = item.problemString
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
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ChallengeDetail") as! ChallengeDetailViewController
//        controller.datasource = SudoChallengeDatasource(challenge: challenges[indexPath.item])
//        self.navigationController!.pushViewController(controller, animated: true)
//
//    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        dbg("Segueing")
        if segue.identifier == "ShowChallenge" {
            let index = tableView.indexPathForCell(sender as! UITableViewCell)?.item
            let challengeDetail = segue.destinationViewController as! ChallengeDetailViewController
            challengeDetail.datasource = SudoChallengeDatasource(challenge: ChallengeManager.sharedInstance.challenges[index!])
        }
        
    }
    
//    lazy var fetchedResultsController: NSFetchedResultsController = {
//        let fetchRequest = NSFetchRequest (entityName: "SudoChallenge")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "puzzleId", ascending: true)]
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
//        return fetchedResultsController
//    }()
}
