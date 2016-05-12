//
//  ChallengeDetailViewController.swift
//  SubtleSudoku
//
//  Created by Derek Crous on 08/05/2016.
//  Copyright © 2016 Ludocrous Software. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var controlsView: UIView!
    
    var datasource : SudoChallengeDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        controlsView.setNeedsLayout()
        controlsView.layoutIfNeeded()
        
        collectionView.frame.size.height = collectionView.frame.size.width

        let gridWidth = Int(CGRectGetWidth(collectionView!.frame) / 9)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: gridWidth, height: gridWidth)
        dbg ("Final - Height: \(collectionView.bounds.height) - Width: \(collectionView.bounds.width)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Datasource delegate methods
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        dbg("Calling number of sections")
//        return 1
//    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard datasource != nil else {
            return 0
        }
        return datasource!.numberOfItems
    }
    
    func collectionView(collectionView: UICollectionView,
                          cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BaseCell", forIndexPath: indexPath) as! SelectedCell
        
        let (cellValue,isOriginal) = (datasource?.getCellDisplayValueAndType(indexPath.item))!
        
        cell.initialize(indexPath.item, value: cellValue, isOriginal: isOriginal)
        cell.setColors()
        cell.setLabel()
        
        //dbg("Cell value: \(cellValue) - isOrig: \(isOriginal)")
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
