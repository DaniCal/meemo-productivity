//
//  FinalBadgeViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class FinalBadgeViewController: UIViewController {

    var sourceView: VideoViewController?
    
    @IBOutlet weak var popupView: UIView!
    @IBAction func backButtonTouch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        sourceView?.lectureCompleted()
    }
    
    @IBAction func closeButtonTouch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        sourceView?.lectureCompleted()
    }
    
    @IBAction func turnOnNotificationTouch(_ sender: AnyObject) {
        sourceView?.lectureCompleted()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
