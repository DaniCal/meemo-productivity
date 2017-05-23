//
//  Advice.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class Advice{
    
    var title:String
    var description:String
    var number:Int
    
    static let testDescription01 = "Capture everything that is around you. Take all physical things and put them in 1 place."
    
    static let testDescription02 = "Write everything down which is on your mind right now. Make a list with all notes."
    
    static let testDescription03 = "Use a tool to action plan all your ideas and braindump so you can take it into action."
    
    
    init(title: String, description:String, number: Int){
        self.title = title
        self.description = description
        self.number = number
     
    }
    
    static func fetchAdvices() -> [Advice]{
        return [
        Advice(title: "Capture", description: testDescription01, number: 1),
        Advice(title: "Braindump", description: testDescription02, number: 2),
        Advice(title: "Action Plan", description: testDescription03, number: 3)
        ]
    }
    
    func numberImage() -> UIImage{
       return UIImage(named: "number0\(String(number))")!
    }

}
