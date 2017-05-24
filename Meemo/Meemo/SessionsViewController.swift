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
    var lecture:Lecture?
    
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
            
            let button = UIButton(frame: CGRect(x: 20 , y: 30 , width: 20, height: 20))
            button.setTitle("", for: .normal)
            button.setImage(UIImage(named: "badgeCloseIconWhite"), for: .normal)
            button.addTarget(self, action: #selector(closeButtonTouch), for: .touchUpInside)
            destination.view.addSubview(button)
            
        }else if segue.identifier == sessionsListIdentifier,
            let destination = segue.destination as? SessionsListViewController
        {
            destination.lecture = self.lecture
//            destination.sessions = testLecture.sessions
        }
    }
    
    func closeButtonTouch(){
        dismiss(animated: true, completion: nil)
    }
    
}

