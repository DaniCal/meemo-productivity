//
//  Course.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/30/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import Foundation
import UIKit

class Course:NSObject{
    
    var title = ""
    var author = ""
    var imageName = ""
    var portraitName = ""
    var authorSubtitle = ""
    
    init(_ title: String, _ author: String, _ authorSubtitle:String,  _ imageName: String, _ portraitName: String){
        self.title = title
        self.author = author
        self.authorSubtitle = authorSubtitle
        self.imageName = imageName
        self.portraitName = portraitName
    }
    
    static func fetchCourses() -> [Course]{
        return [
            Course("Leadership in Tech", "Christian Rebernik", "CTO at N26, Zanox & Parship", "background3", "portraitSuster"),
            Course("Leadership Advice for Founders", "Mark Suster", "CTO at WuffelPuffel", "background2", "portraitSuster"),
            Course("B2B Sales in a Startup", "Daniel Pink", "CEO at FlauschiPaufi",  "background1", "portraitSuster")

        ]
    }

    
}
