//
//  Session.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//


import UIKit

class Session:NSObject{
    var title = ""
    var duration:Int
    var watched:Bool
    var next:Bool
    var url:String
    
    static let testURL1 = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/01_capture_6_min.mp4?alt=media&token=db5eac20-ee3e-422c-980f-b8e1c4004e6b"
    static let testURL2 = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/02_mind_sweep_6_min.mp4?alt=media&token=4b865d5c-1b08-4e08-9ce5-3c787f49982a"
    
    static let testURL3 = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/03_pen_and_paper_6_min.mp4?alt=media&token=f5f11101-f073-4d7c-baa2-350b369a665a"
    
    static let testURL4 = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/04_best_practice_6_min.mp4?alt=media&token=5098a0bf-3296-40c2-a5a5-3688a77a5a09"
    
    static let testURL5 = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/05_final_thoughts_6_min.mp4?alt=media&token=8cb9413a-5e14-46dc-8d43-8ea59cf29907"
    
    static let testURL6 = "https://firebasestorage.googleapis.com/v0/b/meemo-external-test.appspot.com/o/06_summary_6_min.mp4?alt=media&token=a340ffcc-a46d-4a8c-86a0-cecaad0d5ec3"
    
    
    init(title: String, duration:Int, watched:Bool, next:Bool, url:String){
        self.title = title
        self.duration = duration
        self.watched = watched
        self.next = next
        self.url = url
    }
    
    override init(){
        self.title = ""
        self.duration = 0
        self.watched = false
        self.next = false
        self.url = ""
    }
    
    static func fetchSessions() -> [Session]{
        return[
            Session(title: "Capture your physical things", duration: 80, watched: true, next:false, url: testURL1),
            Session(title: "Mind Sweep", duration: 91, watched: true, next:false, url: testURL2),
            Session(title: "Tools for your Mind Sweep", duration: 57, watched: true, next:false, url: testURL3),
            Session(title: "Tools and Best Practice", duration: 101, watched: true, next:false, url: testURL4),
            Session(title: "Final Thoughts", duration: 71, watched: true, next:false, url: testURL5),
            Session(title: "Summary", duration: 64, watched: false, next:true, url: testURL6)
        ]
    }
    
//    func timeAsString() -> String{
//        let minutes = Int(duration / 60)
//        let seconds = duration - (minutes * 60)
//        var secondsString = String(seconds)
//        if(seconds < 10){
//            secondsString = "0\(secondsString)"
//        }
//        
//        return "\(String(minutes)):\(secondsString)"
//    }
    
//    func playImage() -> UIImage{
//        if(watched){
//            return UIImage(named: "playButtonEmptyGreen")!
//        }else{
//            return UIImage(named: "playButtonGrey")!
//        }
//    }

    
}
