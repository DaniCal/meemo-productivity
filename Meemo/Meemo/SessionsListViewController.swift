//
//  SessionsListViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class SessionsListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    @IBOutlet weak var watchButton: UIButton!
    var lectures:[Lecture] = []
    var lecture:Lecture?
    var lectureNumber:Int = 0
    let interactor = Interactor()
    let videoSegueIdentifier = "showVideo"
    let summarySegueIdentifier = "showSummary"
    var selectedRow:Int = 0
    var sourceView:SessionsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures
        lecture = lectures[lectureNumber]
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        tableView.isOpaque = false
        tableView.backgroundView = nil

        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        if(lecture?.watched)!{
            watchButton.setImage(UIImage(named: "watchAgainButton"), for: .normal)
        }else if(lecture?.sessions[0].next)!{
            watchButton.setImage(UIImage(named: "watchCourseButton"), for: .normal)
        }else{
            watchButton.setImage(UIImage(named: "watchContinueButton"), for: .normal)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures
        lecture = lectures[lectureNumber]

        if(lecture?.watched)!{
            watchButton.setImage(UIImage(named: "watchAgainButton"), for: .normal)
        }else if(lecture?.sessions[0].next)!{
            watchButton.setImage(UIImage(named: "watchCourseButton"), for: .normal)
        }else{
            watchButton.setImage(UIImage(named: "watchContinueButton"), for: .normal)
        }
    }
    
    @IBAction func watchButtonAction(_ sender: AnyObject) {
        
        if(lecture?.watched)!{
            self.performSegue(withIdentifier: videoSegueIdentifier , sender: 0)
        }else{
            var count = 0
            count = (lecture?.sessions.count)! - 1
            for index in 1...count{
                if(lecture?.sessions[index].next)!{
                    selectedRow = index
                }
            }
            self.performSegue(withIdentifier: videoSegueIdentifier , sender: nil)
        }
    }
    
    func lectureCompleted(){
        sourceView?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == videoSegueIdentifier,
            let destination = segue.destination as? VideoViewController
        {
            destination.transitioningDelegate = self
            destination.interactor = interactor
            destination.lectureNumber = self.lectureNumber
            destination.sessionNumber = selectedRow
            destination.sourceView = self
            
        }
        else if segue.identifier == summarySegueIdentifier,
                let destination = segue.destination as? SummaryViewController
        {
            destination.transitioningDelegate = self
            destination.interactor = interactor
            destination.lectureNumber = lectureNumber
        }

    }
    
    @IBAction func readSummary(_ sender: AnyObject) {
        self.performSegue(withIdentifier: summarySegueIdentifier , sender: nil)
    }
    
}

extension SessionsListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
}

extension SessionsListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lecture?.sessions.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionTableViewCell
        cell.session = self.lecture?.sessions[indexPath.row]
        return cell
    }

}

extension SessionsListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(lectures[lectureNumber].sessions[indexPath.row].next == true ||
            lectures[lectureNumber].sessions[indexPath.row].watched == true){
            selectedRow = indexPath.row
            self.performSegue(withIdentifier: videoSegueIdentifier , sender: indexPath)
        }
        
    }
    
    
}
