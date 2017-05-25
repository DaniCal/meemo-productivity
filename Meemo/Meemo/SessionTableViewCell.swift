//
//  SessionTableViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButtonImage: UIImageView!
    
       override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var session: Session?{
        didSet{
            self.updateUI()
        }
    }
    
    fileprivate func updateUI(){
        
        if let session = session {
            titleLabel.text = session.title
            titleLabel.font = getFont(16)
            titleLabel.alpha = getAlpha()
            timeLabel.text = timeAsString()
            timeLabel.font = getFont(13)
            timeLabel.alpha = getAlpha()
            playButtonImage.image = getButtonImage()
        }else{
            titleLabel.text = nil
            timeLabel.text = nil
            playButtonImage.image = nil
        }
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    fileprivate func getFont(_ size: Int) -> UIFont{
        if(session?.watched)!{
            return UIFont (name: "Avenir-Light", size: CGFloat(size))!
        }else if (session?.next)!{
            return UIFont (name: "Avenir-Heavy", size: CGFloat(size))!
        }else{
            return UIFont (name: "Avenir-Light", size: CGFloat(size))!
        }
    }
    
    fileprivate func getAlpha()-> CGFloat{
        if(session?.watched)!{
            return 1.0
        }else if (session?.next)!{
            return 1.0
        }else{
            return 0.5
        }
    }

    fileprivate func getButtonImage() -> UIImage{
        if(session?.watched)!{
            return UIImage(named: "playButtonEmptyGreen")!
        }else if(session?.next)!{
            return UIImage(named: "playButtonFullGreen")!
        }else{
            return UIImage(named: "playButtonGrey")!
        }
    }
    
    fileprivate func timeAsString() -> String{
        let minutes = Int((session?.duration)! / 60)
        let seconds = (session?.duration)! - (minutes * 60)
        var secondsString = String(seconds)
        if(seconds < 10){
            secondsString = "0\(secondsString)"
        }
        
        return "\(String(minutes)):\(secondsString)"
    }

}
