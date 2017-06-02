//
//  HomeTableViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/30/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var authorSubtitle: UILabel!

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var course: Course?{
        didSet{
            self.updateUI()
        }
    }
    
    fileprivate func updateUI(){
        
        if let course = course {
            courseTitle.text = course.title
            author.text = course.author
            authorSubtitle.text = course.authorSubtitle
            portrait.image = UIImage(named: course.portraitName)
            backgroundImage.image = UIImage(named: course.imageName)
            
            view.layer.cornerRadius = 12
            view.layer.masksToBounds = true

            
        }else{
            author.text = ""
            authorSubtitle.text = ""
            courseTitle.text = ""
            portrait.image = nil
            backgroundImage.image = nil
            
        }
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }
    
    

}
