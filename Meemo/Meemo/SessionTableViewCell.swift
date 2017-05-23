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
    
    private func updateUI(){
        
        if let session = session {
            titleLabel.text = session.title
            timeLabel.text = session.timeAsString()
            playButtonImage.image = session.playImage()
        }else{
            titleLabel.text = nil
            timeLabel.text = nil
            playButtonImage.image = nil
        }
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }


}
