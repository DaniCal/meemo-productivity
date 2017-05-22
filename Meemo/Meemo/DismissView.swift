//
//  DismissView.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable class DismissView: UIView {
    
    @IBOutlet weak var button: UIButton!
    var view: UIView!
    
    func xibSetup() {
        
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let view = UINib(nibName: "DismissView", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
        
    }
    
    override func awakeFromNib(){
        //        playerLayer = AVPlayerLayer(player: player)
        //        playerLayer?.frame = view.bounds
        //        self.view.layer.addSublayer(playerLayer!)
    }
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }


}
