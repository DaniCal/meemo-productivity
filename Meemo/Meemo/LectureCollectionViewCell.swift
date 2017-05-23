//
//  LectureCollectionViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class LectureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var watchImageView: UIImageView!
    
    var lecture: Lecture?{
        didSet{
            self.updateUI()
        }
    }
    
    private func updateUI(){
        
        if let lecture = lecture {
            self.titleLabel.text = lecture.title
            self.featuredImageView.image = lecture.featuredImage
            self.dayLabel.text = lecture.dayTitle()
            self.watchImageView.image = lecture.watchButtonImage()
            self.completedLabel.isHidden = (lecture.watched == false)
        }else{
            self.titleLabel.text = nil
            self.featuredImageView.image = nil
            self.dayLabel.text = nil
            self.watchImageView.image = nil
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
