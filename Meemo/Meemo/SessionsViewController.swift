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
    
    var headerSegueIdentifier = "sessionsHeader"
    var sessionsListIdentifier = "sessionsList"

    var testLecture = Lecture.fetchLecture()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let overlay = DismissView()
        overlay.frame = self.view.bounds
        overlay.button.addTarget(self, action: #selector(self.dismissSessionsList), for: UIControlEvents.touchUpInside)
        //self.view.addSubview(overlay)


    }
    
    func dismissSessionsList(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Triggers when segues to ProgramView
        if  segue.identifier == headerSegueIdentifier,
            let destination = segue.destination as? SessionsHeaderViewController
        {
            //destination.something
            
        }else if segue.identifier == sessionsListIdentifier,
            let destination = segue.destination as? SessionsListViewController
        {
            destination.sessions = testLecture.sessions
        }
    }
    
}

