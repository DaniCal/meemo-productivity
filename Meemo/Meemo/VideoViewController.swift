//
//  VideoViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    var interactor:Interactor? = nil
    var videoURL:String?
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
