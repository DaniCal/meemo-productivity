//
//  Advice.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/23/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit

class Advice:NSObject{
    
    var title:String
    var text:String
    var number:Int
    
    static let testDescription01 = "Capture everything that is around you. Take all physical things and put them in 1 place."
    
    static let testDescription02 = "Write everything down which is on your mind right now. Make a list with all notes."
    
    static let testDescription03 = "Use a tool to action plan all your ideas and braindump so you can take it into action."
    
    
    init(title: String, text:String, number: Int){
        self.title = title
        self.text = text
        self.number = number
     
    }
    
    override init(){
        self.title = ""
        self.text = ""
        self.number = 0
    }
    
    static func fetchAdvices() -> [Advice]{
        return [
        Advice(title: "Capture", text: testDescription01, number: 1),
        Advice(title: "Braindump", text: testDescription02, number: 2),
        Advice(title: "Action Plan", text: testDescription03, number: 3)
        ]
    }
    
    func numberImage() -> UIImage{
       return UIImage(named: "number0\(String(number))")!
    }

}
