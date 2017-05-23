//
//  Session.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//


import UIKit

class Session{
    var title = ""
    var duration:Int
    var watched:Bool
    var url:String
    
    static let testURL1 = ""
    static let testURL2 = ""
    static let testURL3 = ""
    static let testURL4 = ""
    static let testURL5 = ""
    static let testURL6 = ""
    
    init(title: String, duration:Int, watched:Bool, url:String){
        self.title = title
        self.duration = duration
        self.watched = watched
        self.url = url
    }
    
    static func fetchSessions() -> [Session]{
        return[
            Session(title: "Capture your physical things", duration: 80, watched: true, url: testURL1),
            Session(title: "Mind Sweep", duration: 91, watched: false, url: testURL2),
            Session(title: "Tools for your Mind Sweep", duration: 57, watched: false, url: testURL3),
            Session(title: "Tools and Best Practice", duration: 101, watched: false, url: testURL4),
            Session(title: "Final Thoughts", duration: 71, watched: false, url: testURL5),
            Session(title: "Summary", duration: 64, watched: false, url: testURL6)
        ]
    }
    
    func timeAsString() -> String{
        let minutes = Int(duration / 60)
        let seconds = duration - (minutes * 60)
        var secondsString = String(seconds)
        if(seconds < 10){
            secondsString = "0\(secondsString)"
        }
        
        return "\(String(minutes)):\(secondsString)"
    }
    
    func playImage() -> UIImage{
        if(watched){
            return UIImage(named: "playButtonFullGreen")!
        }else{
            return UIImage(named: "playButtonEmptyGreen")!
        }
    }

    
}
