//
//  SummaryTableViewCell.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var numberImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    var advice: Advice?{
        didSet{
            self.updateUI()
        }
    }
    
    fileprivate func updateUI(){
        
        if let advice = advice {
            title.text = advice.title
            descriptionLabel.text = advice.text
            numberImage.image = advice.numberImage()
            
        }else{
            descriptionLabel.text = nil
            title.text = nil
            numberImage = nil
        }
        
    }

}
