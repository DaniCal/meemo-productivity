//
//  ViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class LecturesViewController: UIViewController {

    var lectures:[Lecture] = []
    var cellScalingX:CGFloat = 0.653
    var cellScalingY:CGFloat = 0.72
    let sessionsSegueIdentifier = "showSessions"

    var selectedIndex:Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures
        
        let screenSize = UIScreen.main.bounds.size
        
        //If iphone 5 screen
        if(screenSize.height == 568.0){
            cellScalingX = 0.78
        }
        
        let cellWidth = floor(screenSize.width * cellScalingX)
        let cellHeight = floor(screenSize.height * cellScalingY)

        let insetX = (view.bounds.width - cellWidth) / 2
        let insetY = (view.bounds.height - cellHeight) / 2

        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth , height: cellHeight)

        collectionView?.contentInset = UIEdgeInsets(top: insetY ,left: insetX , bottom: insetY, right: insetX)

        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Triggers when segues to ProgramView
        if  segue.identifier == sessionsSegueIdentifier,
            let destination = segue.destination as? SessionsViewController
        {
//            destination.lecture = lectures[selectedIndex]
            destination.lectureNumber = selectedIndex
        }
    }

}

extension LecturesViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lectures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LectureCell", for: indexPath) as! LectureCollectionViewCell
        
        cell.lecture = lectures[indexPath.item]
        
        return cell
    }
    
}

extension LecturesViewController: UIScrollViewDelegate, UICollectionViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self .collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(self.lectures[indexPath.item].locked){
            return
        }
        
        selectedIndex = indexPath.item
        self.performSegue(withIdentifier: sessionsSegueIdentifier , sender: indexPath)
        

    }
}

