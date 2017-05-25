//
//  Lecture.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class Lecture:NSObject{
    
    var title = ""
    var imageURL = ""
    var featuredImage: UIImage
    var number: Int
    var locked: Bool
    var watched: Bool
    var sessions:[Session]
    
    
    /*
     TODO
     var backgroundURL:String
     var parallaxURL:String
     var summaryPoints:[SummaryPoint]
    */
    
    init(title: String, featuredImage: UIImage, number: Int, locked: Bool, watched: Bool){
        self.title = title
        self.featuredImage = featuredImage
        self.number = number
        self.locked = locked
        self.watched = watched
        self.sessions = Session.fetchSessions()
    }
    
    override init(){
        self.title = ""
        self.featuredImage = UIImage(named: "carouselBackgroundPlaceholder")!
        self.number = 0
        self.locked = false
        self.watched = false
        self.sessions = []

    }
    
    static func fetchLectures() -> [Lecture]{
        return[
            Lecture(title: "Capture what's on your mind", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 1,  locked: false, watched: true),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 2,  locked: false, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 3,  locked: true, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 4,  locked: true, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 5,  locked: true, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 6,  locked: true, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 7,  locked: true, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 8,  locked: true, watched: false)

        ]
    }
    
    static func fetchLecture() -> Lecture{
        return Lecture(title: "Capture what's on your mind", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 1,  locked: false, watched: true)
    }
    
    func dayTitle()-> String{
        return "Lecture \(String(number))"
    }
    
    func watchButtonImage() -> UIImage{
        if(locked){
            return UIImage(named: "lockedButton")!
        }else if(watched){
            return UIImage(named: "watchButtonWhite")!
        }else{
            return UIImage(named: "watchButtonGreen")!
        }
    }
    
}
