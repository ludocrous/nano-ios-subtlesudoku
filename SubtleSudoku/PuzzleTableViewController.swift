//
//  ProblemTableViewController.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 26/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

class PuzzleTableViewController: UITableViewController{
    
    var activityView: UIActivityIndicatorView?
    var activityBlur: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Puzzles"
        loadPuzzleList()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshView()
    }
    
    func loadPuzzleList() {
        let effect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        activityBlur = UIVisualEffectView(effect: effect)
        activityBlur!.frame = self.view.bounds;
        self.view.addSubview(activityBlur!)
        
        activityView  = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityView?.center = self.view.center
        activityView?.color = UIColor.blackColor()
        activityView?.startAnimating()
        self.view.addSubview(activityView!)
        
        DyDBManager.sharedInstance.loadSudokuPuzzles() { (success,errorString) in

            self.activityView?.stopAnimating()
            self.activityView?.removeFromSuperview()
            self.activityBlur?.removeFromSuperview()
            if success {
                dbg("Succesfull load of puzzles - \(DyDBManager.sharedInstance.puzzles.count)")
                self.refreshView()
            } else {
                displayAlertOnMainThread("Error", message: errorString, onViewController: self)
                err("There is a problem loading puzzles")
            }
        }
        

    }
    
    func refreshView() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DyDBManager.sharedInstance.puzzles.count
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Configure the cell...
        let item = DyDBManager.sharedInstance.puzzles[indexPath.row]
        if ChallengeManager.sharedInstance.hasChallengeWithId(item.puzzleId!) {
            cell.textLabel?.text = "\(item.puzzleId!) - (Challenge accepted)"
            cell.textLabel?.textColor = UIColor.redColor()
        } else {
            cell.textLabel?.text = "\(item.puzzleId!)"
            cell.textLabel?.textColor = UIColor.blackColor()
        }
            
            if let myDetailTextLabel = cell.detailTextLabel {
                //myDetailTextLabel.text = item.problemString
                myDetailTextLabel.text = "Unresolved Cells: \(item.unsolvedCount())"
            }
            
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        dbg("Segueing")
        if segue.identifier == "ShowPreview" {
            let index = tableView.indexPathForCell(sender as! UITableViewCell)?.item
            let puzzleDetail = segue.destinationViewController as! PuzzleViewController
            //let item = DyDBManager.sharedInstance.puzzles[index!]
            puzzleDetail.puzzleIndex = index!
        }
        
    }
   

   
}
