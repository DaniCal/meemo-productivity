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
    
    var sessions:[Session]?
    let interactor = Interactor()
    let videoSegueIdentifier = "showVideo"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.clear
        tableView.isOpaque = false
        tableView.backgroundView = nil

        
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == videoSegueIdentifier,
            let destination = segue.destination as? VideoViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.transitioningDelegate = self
            destination.interactor = interactor
            destination.videoURL = (sessions?[blogIndex].url)!
            destination.duration = (sessions?[blogIndex].duration)!
            
        }
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
        return (sessions?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionTableViewCell
        cell.session = self.sessions?[indexPath.row]        
        return cell
    }

}

extension SessionsListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: videoSegueIdentifier , sender: indexPath)

        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
