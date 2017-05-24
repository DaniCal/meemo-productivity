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
    
    @IBAction func watchButtonAction(_ sender: AnyObject) {
    }
    
    @IBOutlet weak var watchButton: UIButton!
    var lecture:Lecture?
    let interactor = Interactor()
    let videoSegueIdentifier = "showVideo"
    let summarySegueIdentifier = "showSummary"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == videoSegueIdentifier,
            let destination = segue.destination as? VideoViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.transitioningDelegate = self
            destination.interactor = interactor
            destination.sessions = lecture?.sessions
            destination.index = blogIndex
            
        }
        else if segue.identifier == summarySegueIdentifier,
                let destination = segue.destination as? SummaryViewController
        {
            destination.transitioningDelegate = self
            destination.interactor = interactor
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
        
        self.performSegue(withIdentifier: videoSegueIdentifier , sender: indexPath)
    }
    
    
}
