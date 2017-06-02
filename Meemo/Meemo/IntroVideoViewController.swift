//
//  IntroVideoViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/26/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import AVFoundation
import Mixpanel

class IntroVideoViewController: UIViewController {

      
    var overlay:VideoView?
    var player:AVPlayer?
    var playerLayer:AVPlayerLayer?
    var timer = Timer.init()
    var duration:Float = 170
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playVideo()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateVideoProgress), userInfo: nil,repeats: true)
        
        overlay = VideoView()
        overlay?.setSkipTarget(selector: #selector(self.skipIntro), target: self)
        overlay?.frame = self.view.bounds
        self.view.addSubview(overlay!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func skipIntro(){
        Mixpanel.sharedInstance()?.track("sopped_intro", properties: ["time" : "\(String(describing: player?.currentTime().seconds))"])

        player?.pause()
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        timer.invalidate()
        (UIApplication.shared.delegate as! AppDelegate).showLecturesViewController()
    }
    
    func playVideo(){
        Mixpanel.sharedInstance()?.track("play_intro")

        
        guard let path = Bundle.main.path(forResource: "Intro", ofType:"mp4") else {
            debugPrint("video not found")
            return
        }
        self.player = AVPlayer(url: URL(fileURLWithPath: path))

        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer!)
        self.player?.play()
        NotificationCenter.default.addObserver(self,selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
    }
    
    func updateVideoProgress(){
        let time = Float((self.player?.currentTime().seconds)!)
        
        let ratio = Float(time / duration)
        
        overlay?.setPogress(ratio)
    }
    
    func playerDidFinishPlaying(){
        Mixpanel.sharedInstance()?.track("watched_intro")
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        timer.invalidate()
        (UIApplication.shared.delegate as! AppDelegate).showLecturesViewController()
    }

}
