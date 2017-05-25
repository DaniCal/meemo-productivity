//
//  LectureCollectionViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class LectureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var completeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var watchImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    
    var lecture: Lecture?{
        didSet{
            self.updateUI()
        }
    }
    
    fileprivate func updateUI(){
        
        if let lecture = lecture {
            self.titleLabel.text = lecture.title
            self.featuredImageView.image = lecture.featuredImage
            self.dayLabel.text = lecture.dayTitle()
            self.watchImageView.image = lecture.watchButtonImage()
            self.completeImage.isHidden = (lecture.watched == false)
            self.overlayView.alpha = getOverlayAlpha()
        }else{
            self.titleLabel.text = nil
            self.featuredImageView.image = nil
            self.dayLabel.text = nil
            self.watchImageView.image = nil
        }
        
    }

    fileprivate func getOverlayAlpha() -> CGFloat{
        if(lecture?.locked)!{
            return CGFloat(1)
        }else{
            return CGFloat(0.4)
        }
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 3.0
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
}
