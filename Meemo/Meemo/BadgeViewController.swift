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
    var lectureNumber = 0
    var sessionNumber = 0

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        if(lectureNumber == 0){
            switch(sessionNumber){
            case 0:
                setFirstBadge()
                break;
            case 1:
                setSecondBadge()
                break;
            case 2:
                setThirdBadge()
                break;
            case 3:
                setFourthBadge()
                break;
            case 4:
                setFithBadge()
                break;
            default:
                setFithBadge()
                break;
            }
        }else{
            let randomNum:UInt32 = arc4random_uniform(3)
            switch(randomNum){
            case 0:
                setThirdBadge()
                break;
            case 1:
                setFourthBadge()
                break;
            case 2:
                setFithBadge()
                break;
            default:
                setFithBadge()
                break;
            }
        }
        
        
    }
    
    func setFirstBadge(){
        imageView.image = UIImage(named: "badgeEmojiHands")
        titleLabel.text = "Awesome Job!"
        textLabel.text = "You’ve watched your first video. On to the next one!"
    }
    
    func setSecondBadge(){
        imageView.image = UIImage(named: "badgeEmojiClaps")
        titleLabel.text = "Well Done!"
        textLabel.text = "What a progress! 2 videos in a row. Keep it up!"
    }
    
    func setThirdBadge(){
        imageView.image = UIImage(named: "badgeEmojiExcellent")
        titleLabel.text = "Fine Job!"
        textLabel.text = "Keep the streak! Well done!"
    }
    
    func setFourthBadge(){
        imageView.image = UIImage(named: "badgeEmojiRock")
        titleLabel.text = "You Rock!"
        textLabel.text = "You are on a mission. Keep the flow going."
    }
    
    func setFithBadge(){
        imageView.image = UIImage(named: "badgeEmojiFire")
        titleLabel.text = "You’re on Fire!"
        textLabel.text = "You are hot right now. You can do more!"
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
