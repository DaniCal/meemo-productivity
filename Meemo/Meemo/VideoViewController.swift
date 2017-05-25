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
    var timer = Timer.init()
    
    var lectures:[Lecture] = []
    var sessionNumber:Int = 0
    var lectureNumber:Int = 0
    var sourceView:SessionsListViewController?

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var overlay:VideoView?
    
    var player:AVPlayer?
    var playerLayer:AVPlayerLayer?
    
    let showBadgeIdentidier = "showBadge"
    let showFinalBadgeIdentidier = "showFinalBadge"


//    var sessions:[Session]?
//    var index:Int?
//    var currentSession:Session?
    
//    let videoTestURL = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/01_capture_6_min.mp4?alt=media&token=db5eac20-ee3e-422c-980f-b8e1c4004e6b"

    func dismissVideoView(){
        dismiss(animated: true, completion: nil)
    }
    
    func lectureCompleted(){
        sourceView?.lectureCompleted()
        dismiss(animated: true, completion: nil)
    }
    
    func playNextVideo(){
            sessionNumber = sessionNumber + 1
            playVideo()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateVideoProgress), userInfo: nil,repeats: true)
            overlay = VideoView()
            overlay?.frame = self.view.bounds
            self.view.addSubview(overlay!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == showBadgeIdentidier){
            if let destination = segue.destination as? BadgeViewController{
                destination.sourceView = self
            }
        }else if (segue.identifier == showFinalBadgeIdentidier){
            if let destination = segue.destination as? FinalBadgeViewController{
                destination.sourceView = self
            }
        }
    }
    
    
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
            player?.pause()
            timer.invalidate()
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
                player?.play()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateVideoProgress), userInfo: nil,repeats: true)
            }
        default: break
            
        }
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lectures = (UIApplication.shared.delegate as! AppDelegate).lectures

        
//        currentSession = sessions?[index!]
        
        self.player?.pause()
        playVideo()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateVideoProgress), userInfo: nil,repeats: true)
        
        overlay = VideoView()
        overlay?.frame = self.view.bounds
        self.view.addSubview(overlay!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func playVideo(){
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        let url = URL(string: (lectures[lectureNumber].sessions[sessionNumber].url))
        self.player = AVPlayer(url: url!)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer!)
        self.player?.play()
        NotificationCenter.default.addObserver(self,selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)

        

    }
    
    func sessionWatched(){
        //Set Session as watched and not the next
        var sessions = lectures[lectureNumber].sessions
        sessions[sessionNumber].watched = true
        sessions[sessionNumber].next = false
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var lecturesMO: [LectureMO] = []
        do{
            lecturesMO = try context.fetch(LectureMO.fetchRequest())
            let sessionsMO = lecturesMO[lectureNumber].sessions?.allObjects as! [SessionMO]
            for sessionMO in sessionsMO {
                if(sessionMO.number == Int16(sessionNumber)){
                    sessionMO.watched = true
                    sessionMO.next = false
                }
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch{
            print("Fetching failed!")
        }
    }
    
    func sessionNext(){
        var sessions = lectures[lectureNumber].sessions
        sessions[sessionNumber + 1].next = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var lecturesMO: [LectureMO] = []
        do{
            lecturesMO = try context.fetch(LectureMO.fetchRequest())
            let session = SessionMO(context: context)
            session.next = true
            session.watched = false
            session.number = Int16(sessionNumber + 1)
            lecturesMO[lectureNumber].addToSessions(session)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch{
            print("Fetching failed!")
        }
    }
    
    func lectureWatched(){
        lectures[lectureNumber].watched = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var lecturesMO: [LectureMO] = []
        do{
            lecturesMO = try context.fetch(LectureMO.fetchRequest())
            lecturesMO[lectureNumber].watched = true
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }catch{
            print("Fetching failed!")
        }

    }
    
    func lectureUnlock(){
        lectures[lectureNumber + 1].locked = false
        lectures[lectureNumber + 1].sessions[0].next = true
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let lecture = LectureMO(context: context)
        lecture.number = lectureNumber + 1
        lecture.watched = false
        lecture.locked = false
        
        let session = SessionMO(context: context)
        session.next = true
        session.watched = false
        
        lecture.addToSessions(session)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func playerDidFinishPlaying(){
        
        timer.invalidate()
        overlay?.setPogress(1)
        overlay?.removeFromSuperview()
        playerLayer?.removeFromSuperlayer()
        
        sessionWatched()
        
        if(sessionNumber < (lectures[lectureNumber].sessions.count - 1)){ // Are there more sessions to watch?
            
            //Set next session as next
            if(lectures[lectureNumber].sessions[sessionNumber + 1].watched == false){
                
                sessionNext()
            }
            
            
            self.performSegue(withIdentifier: showBadgeIdentidier , sender: nil)
        }
        else{ // Lecture was completed
            
           lectureWatched()
            
            //Set next lecture as unlocked
            if(lectureNumber < lectures.count - 1){
               lectureUnlock()
                
                self.performSegue(withIdentifier: showFinalBadgeIdentidier , sender: nil)
            }else{
                //Show you've finished the course badge
            }
        }
        
    }
    
    func updateVideoProgress(){
        let time = Float((self.player?.currentTime().seconds)!)
        let ratio = time / Float((lectures[lectureNumber].sessions[sessionNumber].duration))
        if(ratio > 0){
           spinner.isHidden = true
        }
        overlay?.setPogress(ratio)
    }
}
