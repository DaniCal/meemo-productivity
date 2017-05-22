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
    var index: Int
    var completed:Bool
    
    init(title: String, featuredImage: UIImage, index: Int, completed: Bool){
        self.title = title
        self.featuredImage = featuredImage
        self.index = index
        self.completed = completed
    }
    
}
