//
//  BadgeViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class BadgeViewController: UIViewController {

    var sourceView: VideoViewController?

    
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    
    @IBAction func watchNextButtonTouch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        sourceView?.playNextVideo()
    }
    
    @IBAction func closeButtonTouch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        sourceView?.dismissVideoView()
    }
    
    @IBAction func backButtonTouch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        sourceView?.dismissVideoView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    


}
