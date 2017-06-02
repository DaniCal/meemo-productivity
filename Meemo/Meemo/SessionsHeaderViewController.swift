//
//  SessionsHeaderViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//


import UIKit

class SessionsHeaderViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var lectureNumber = 0
    var lectures: [Lecture] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures
        lectureNumber = (UIApplication.shared.delegate as! AppDelegate).selectedLecture
        titleLabel.text = lectures[lectureNumber].title
        backgroundImageView.image = lectures[lectureNumber].featuredImage


    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
