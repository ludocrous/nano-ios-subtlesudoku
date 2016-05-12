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
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet var selectionButtons: [UIButton]!
    @IBOutlet weak var easyModeSwitch: UISwitch!
    
    var datasource : SudoChallengeDatasource?
    var selectedCellIndex: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setSelectionControlsEnabled(false)
        navigationItem.title = datasource!.challengeName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayout() {
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
        collectionView.allowsSelection = true
    }
    
    func setSelectionControlsEnabled (enabled: Bool) {
        for button in selectionButtons {
            button.enabled = enabled
        }
    }
    
    //MARK: - Datasource delegate methods
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard datasource != nil else {
            return 0
        }
        return datasource!.numberOfItems
    }
    
    func collectionView(collectionView: UICollectionView,
                          cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BaseCell", forIndexPath: indexPath) as! SelectedCell
        
        let cellValue = (datasource?.getCellDisplayValue(indexPath.item))!
        let isOriginal = (datasource?.isOriginalValue(indexPath.item))!
        let isCorrect = (datasource?.isCellCorrect(indexPath.item))!
        cell.initialize(indexPath.item, value: cellValue, isOriginal: isOriginal)
        cell.displayCorrectStatus = easyModeSwitch.on
        cell.isCorrect = isCorrect
        cell.setColors()
        cell.setLabel()
        if let selectInd = selectedCellIndex where selectInd == indexPath{
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.blueColor().CGColor
        } else {
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.blackColor().CGColor
        }
        
        //dbg("Cell value: \(cellValue) - isOrig: \(isOriginal)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        if !datasource!.isOriginalValue(indexPath.item) {
            var refresh: [NSIndexPath] = [indexPath]
            if let oldIndexPath = selectedCellIndex {
                refresh.append(oldIndexPath)
            }
            selectedCellIndex = indexPath
            collectionView.reloadItemsAtIndexPaths(refresh)
            setSelectionControlsEnabled(true)
        }
    }

    //MARK: Selction Controls
    
    @IBAction func easyModeSwitched(sender: AnyObject) {
        collectionView.reloadData()
    }
    
    @IBAction func selectionButtonPressed(sender: AnyObject) {
        if let index = selectedCellIndex {
            let button = sender as! UIButton
            if !(datasource?.isOriginalValue(index.item))! {
                datasource?.setUserValue(index.item, value: button.tag)
                collectionView.reloadItemsAtIndexPaths([index])
            }
        }
        
    }
    
    @IBAction func resetChallenge(sender: AnyObject) {
        datasource!.resetChallenge()
        collectionView.reloadData()
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
