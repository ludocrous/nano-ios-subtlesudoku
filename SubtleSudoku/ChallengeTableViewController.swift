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
    
    
    var challenges = [SudoChallenge]()
    
    
    override func viewDidLoad() {
        loadChallenges()
    }
    
    
    
    func loadChallenges() {
        challenges = fetchAllChallenges()
        dbg("Challenges loaded - record count: \(challenges.count)")
    }
    
    func fetchAllChallenges() -> [SudoChallenge] {
        let fetchRequest = NSFetchRequest(entityName: "SudoChallenge")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [SudoChallenge]
        } catch let error as NSError {
            print("Error in SudoChallenge fetch - \(error)")
            return [SudoChallenge]()
        }
    }
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance.managedObjectContext
    }()

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        dbg("Number of secs being called")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        dbg("Number of rows being called")
        return challenges.count
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        dbg("cell for row being called")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let item = challenges[indexPath.row]
        cell.textLabel?.text = "Challenge: \(item.puzzleId)"
        
        if let myDetailTextLabel = cell.detailTextLabel {
            myDetailTextLabel.text = item.problemString
        }
        
        return cell
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
        if segue.identifier == "Selection" {
            let index = tableView.indexPathForCell(sender as! UITableViewCell)?.item
            let challengeDetail = segue.destinationViewController as! ChallengeDetailViewController
            challengeDetail.datasource = SudoChallengeDatasource(challenge: challenges[index!])
        }
        
    }
    
//    lazy var fetchedResultsController: NSFetchedResultsController = {
//        let fetchRequest = NSFetchRequest (entityName: "SudoChallenge")
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "puzzleId", ascending: true)]
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
//        return fetchedResultsController
//    }()
}
