//
//  SessionsViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import MXParallaxHeader


class SessionsViewController: MXScrollViewController {
    @IBOutlet weak var dismissButton: UIButton!
    
    
    var headerSegueIdentifier = "sessionsHeader"
    var sessionsListIdentifier = "sessionsList"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Triggers when segues to ProgramView
//        if  segue.identifier == headerSegueIdentifier,
//            let destination = segue.destination as? TopicHeaderViewController
//        {
//            //destination.something
//            
//        }else if segue.identifier == topicListIdentifier,
//            let destination = segue.destination as? TopicListViewController
//        {
//            //destination.something
//        }
    }
    
}

