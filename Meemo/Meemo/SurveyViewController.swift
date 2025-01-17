//
//  SurveyViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/26/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import Mixpanel

class SurveyViewController: UIViewController {

    @IBOutlet weak var label5: UIView!
    
    @IBOutlet weak var label4: UIView!
    @IBOutlet weak var label3: UIView!
    
    @IBOutlet weak var label2: UIView!
    @IBOutlet weak var label1: UIView!
    
    var date = ""
    
    @IBAction func closeSurveyAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        Mixpanel.sharedInstance()?.track("answer_survey", properties: ["answer" : "\(date): -1"])
    }
    
    
    @IBAction func selected5(_ sender: Any) {
        Mixpanel.sharedInstance()?.track("answer_survey", properties: ["answer" : "\(date): 5"])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selected4(_ sender: Any) {
        Mixpanel.sharedInstance()?.track("answer_survey", properties: ["answer" : "\(date): 4"])
        dismiss(animated: true, completion: nil)
    }
    @IBAction func selected3(_ sender: Any) {
        Mixpanel.sharedInstance()?.track("answer_survey", properties: ["answer" : "\(date): 3"])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selected2(_ sender: Any) {
        Mixpanel.sharedInstance()?.track("answer_survey", properties: ["answer" : "\(date): 2"])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selected1(_ sender: Any) {
        Mixpanel.sharedInstance()?.track("answer_survey", properties: ["answer" : "\(date): 1"])
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day!
        
        self.date = "\(day)_\(month!)_\(year!)"

        label5.layer.cornerRadius = 13
        label5.layer.masksToBounds = true
        
        label4.layer.cornerRadius = 13
        label4.layer.masksToBounds = true
        
        label3.layer.cornerRadius = 13
        label3.layer.masksToBounds = true
        
        label2.layer.cornerRadius = 13
        label2.layer.masksToBounds = true
        
        label1.layer.cornerRadius = 13
        label1.layer.masksToBounds = true
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
