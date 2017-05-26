//
//  VideoView.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

@IBDesignable class VideoView: UIView {

    var view: UIView!

    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var videoProgress: UIProgressView!
    open func setPogress(_ progress: Float){
        videoProgress.setProgress(progress, animated: true)
    }
    
    
    open func setSkipTarget(selector: Selector, target: Any?){
        self.skipButton.isHidden = false
        self.skipButton.addTarget(target, action: selector, for: .touchUpInside)
//        self.skipButton.target(forAction: selector, withSender: sender)
    }
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
        let view = UINib(nibName: "VideoView", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
        
    }
    
    override func awakeFromNib(){
        
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
