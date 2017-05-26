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
    var lectures: [Lecture] = []
    var lectureNumber = 0
    
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
        if(!courseCompleted){
            (UIApplication.shared.delegate as! AppDelegate).enableNotification()
        }
        sourceView?.lectureCompleted()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        var isRegisteredForRemoteNotifications = false
       
        
        let notificationType = UIApplication.shared.currentUserNotificationSettings!.types
        if notificationType == [] {
            isRegisteredForRemoteNotifications = false
        } else {
            isRegisteredForRemoteNotifications = true
        }
    
        
        if(courseCompleted){
            button.setTitle("Learn More",for: .normal)
            reminderLabel.isHidden = true
            bellImageView.isHidden = true
            lineUIView.isHidden = true
            titleLabel.text = "Congrats!"
            textLabel.text = "You know how to get things done!! Nothing can stop you. Elon better watch out."
        }else if(isRegisteredForRemoteNotifications){
            button.setTitle("Sure",for: .normal)
            reminderLabel.isHidden = true
            bellImageView.isHidden = true
            lineUIView.isHidden = true
            titleLabel.text = "Congrats!"
            textLabel.text = "You've completed your day. See you back here tomorrow!"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
