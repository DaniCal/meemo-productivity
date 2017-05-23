//
//  VideoViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import AVFoundation


class VideoViewController: UIViewController {

    var interactor:Interactor? = nil
    var videoURL:String?
    
    public var player:AVPlayer?
    var playerLayer:AVPlayerLayer?
    let videoTestURL = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/01_capture_6_min.mp4?alt=media&token=db5eac20-ee3e-422c-980f-b8e1c4004e6b"

    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
//            player?.pause()
//            timer.invalidate()
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            if(interactor.shouldFinish){
                interactor.finish()
            }else{
                interactor.cancel()
//                player?.play()
//                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateVideoProgress), userInfo: nil,repeats: true)
            }
        default: break
            
        }
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.player?.pause()
        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func playVideo(){
       // let time = self.player?.currentTime()
        
        let videoURL = NSURL(string: videoTestURL)
        self.player = AVPlayer(url: videoURL as! URL)
        
        
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer!)
        self.player?.play()
//        NotificationCenter.default.addObserver(self,selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
//        
        
//        if(time != nil){
//            self.player?.seek(to: time!)
//        }

    }
    
}
