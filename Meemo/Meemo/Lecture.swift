//
//  Lecture.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class Lecture{
    
    var title = ""
    var featuredImage: UIImage
    var number: Int
    var locked: Bool
    var watched: Bool
    
    init(title: String, featuredImage: UIImage, number: Int, locked: Bool, watched: Bool){
        self.title = title
        self.featuredImage = featuredImage
        self.number = number
        self.locked = locked
        self.watched = watched
        
    }
    
    static func fetchLectures() -> [Lecture]{
        return[
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 1,  locked: false, watched: true),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 1,  locked: true, watched: false),
            Lecture(title: "Capture", featuredImage: UIImage(named: "carouselBackgroundPlaceholder")!, number: 1,  locked: true, watched: false)

        ]
    }
    
    func dayTitle()-> String{
        return "DAY \(String(number))"
    }
    
    func watchButtonImage() -> UIImage{
        if(locked){
            return UIImage(named: "lockedButton")!
        }else if(watched){
            return UIImage(named: "watchButtonGreen")!
        }else{
            return UIImage(named: "watchButtonWhite")!
        }
    }
    
}
