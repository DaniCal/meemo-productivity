//
//  GetStartedViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/26/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func skipIntro(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        (UIApplication.shared.delegate as! AppDelegate).showLecturesViewController()
    }

   
}
