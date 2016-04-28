//
//  ViewController.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 12/04/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

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
    

    @IBAction func doSomething(sender: UIButton) {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewControllerWithIdentifier("ProblemTableViewController") as! UITableViewController
        self.presentViewController(resultVC, animated: true, completion: nil)
    
    }
    


   

}

