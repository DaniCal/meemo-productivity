//
//  LectureCollectionViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class LectureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var chapterView: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var watchImageView: UIImageView!
    
    let green = UIColor(red: 155/255, green: 234/255, blue: 201/255, alpha: 1.0)
    let red = UIColor(red: 234/255, green: 163/255, blue: 155/255, alpha: 1.0)
    let blue = UIColor(red: 155/255, green: 214/255, blue: 234/255, alpha: 1.0)
    let yellow = UIColor(red: 233/255, green: 234/255, blue: 155/255, alpha: 1.0)
    let green2 = UIColor(red: 183/255, green: 234/255, blue: 155/255, alpha: 1.0)

    let purple = UIColor(red: 159/255, green: 155/255, blue: 234/255, alpha: 1.0)

    let pink = UIColor(red: 234/255, green: 155/255, blue: 226/255, alpha: 1.0)

    
    
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
            self.chapterView.layer.cornerRadius = 10
            self.chapterView.layer.masksToBounds = true

            switch(lecture.number){
            case 1:
                self.chapterView.backgroundColor = blue
                self.mainView.backgroundColor = blue
                break
            case 2:
                self.chapterView.backgroundColor = red
                self.mainView.backgroundColor = red
                break
            case 3:
                self.chapterView.backgroundColor = green
                self.mainView.backgroundColor = green
                break
            case 4:
                self.chapterView.backgroundColor = yellow
                self.mainView.backgroundColor = yellow
                break
            case 5:
                self.chapterView.backgroundColor = green2
                self.mainView.backgroundColor = green2
                break
            case 6:
                self.chapterView.backgroundColor = purple
                self.mainView.backgroundColor = purple
                break
            case 7:
                self.chapterView.backgroundColor = pink
                self.mainView.backgroundColor = pink
                break
            default:
                self.chapterView.backgroundColor = green
                self.mainView.backgroundColor = green
                break
            }
            
        }else{
            self.titleLabel.text = nil
            self.featuredImageView.image = nil
            self.dayLabel.text = nil
            self.watchImageView.image = nil
        }
        
        let screenSize = UIScreen.main.bounds.size
        
        //If iphone 5 screen
        if(screenSize.height == 568.0){
            authorLabel.isHidden = true
        }

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        layer.masksToBounds = true
        

    }
}
