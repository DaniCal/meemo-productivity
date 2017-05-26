//
//  FinalBadgeViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class FinalBadgeViewController: UIViewController {

    var courseCompleted:Bool = false
    
    @IBOutlet weak var iconImageView: UIImageView!
    var sourceView: VideoViewController?
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var bellImageView: UIImageView!

    @IBOutlet weak var lineUIView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
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
        
        
        if(courseCompleted){
            button.setTitle("Learn More",for: .normal)
            reminderLabel.isHidden = true
            bellImageView.isHidden = true
            lineUIView.isHidden = true
            titleLabel.text = "Congrats!"
            textLabel.text = "You know how to get things done!! Nothing can stop you. Elon better watch out."
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
