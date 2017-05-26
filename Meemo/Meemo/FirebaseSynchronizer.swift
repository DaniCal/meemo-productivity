//
//  FirebaseSynchronizer.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/25/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


@objc protocol FirebaseSynchornizeDelegate{
    @objc optional func firebaseDidLoadLectures(_ lectures: [Lecture])
}


class FirebaseSynchronizer: NSObject{
    static var delegate:FirebaseSynchornizeDelegate?
    static let rootRef = FIRDatabase.database().reference()
    
    override init(){
        super.init()
        
    }
    
    
    
    static func subscribeToContent(){
        let conditionRef = rootRef.child("lectures")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            
            var lectures:[Lecture] = []
            let enumerator = snapshot.children
            
            while let lecture = enumerator.nextObject() as? FIRDataSnapshot{
                lectures.append(parseLecture(lecture))
            }
            
            self.delegate?.firebaseDidLoadLectures!(lectures)
            
        })
    }
    
    static func parseLecture(_ lectureSnapshot: FIRDataSnapshot)->Lecture{
        
        let lecture = Lecture()
        lecture.title = (lectureSnapshot.childSnapshot(forPath: "title").value as? String)!
        lecture.imageURL = (lectureSnapshot.childSnapshot(forPath: "imageURL").value as? String)!
        lecture.number = (lectureSnapshot.childSnapshot(forPath: "number").value as? Int)!
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var lecturesMO: [LectureMO] = []
        do{
            lecturesMO = try context.fetch(LectureMO.fetchRequest())
        }catch{
            print("Fetching failed!")
        }
        
        if(lecturesMO.count < lecture.number){
            lecture.locked = true
            lecture.watched = false
        }else{
            lecture.locked = lecturesMO[lecture.number - 1].locked
            lecture.watched = lecturesMO[lecture.number - 1].watched
        }
        
        
        //Parse Summary
        
        let advices = lectureSnapshot.childSnapshot(forPath: "summary")
        let adviceEnumerator = advices.children
        
        while let advice = adviceEnumerator.nextObject() as? FIRDataSnapshot{
            lecture.advices.append(parseAdvice(advice))
        }
        
        
        //Parse Sessions
        let sessions = lectureSnapshot.childSnapshot(forPath: "sessions")
        let enumerator = sessions.children
        
        var index = 0
        while let session = enumerator.nextObject() as? FIRDataSnapshot{
            if((lecture.number - 1) < lecturesMO.count && index < (lecturesMO[lecture.number - 1].sessions?.count)!){
                let sessions = lecturesMO[lecture.number - 1].sessions?.allObjects as! [SessionMO]
                for sessionMO in sessions{
                    if(sessionMO.number == Int16(index)){
                        print(sessionMO.number)
                        lecture.sessions.append(parseSession(session, next: sessionMO.next, watched: sessionMO.watched))
                    }
                }
                
            }else{
                lecture.sessions.append(parseSession(session, next: false, watched: false))
            }
            index = index + 1
        }
        
        return lecture
    }
    
    static func parseSession(_ sessionSnapshot: FIRDataSnapshot, next: Bool, watched: Bool)->Session{
        let session = Session()
        session.title = (sessionSnapshot.childSnapshot(forPath: "title").value as? String)!
        session.url = (sessionSnapshot.childSnapshot(forPath: "url").value as? String)!
        session.duration = (sessionSnapshot.childSnapshot(forPath: "duration").value as? Int)!
        session.next = next
        session.watched = watched
        
        return session
    }
    
    static func parseAdvice(_ adviceSnapshot: FIRDataSnapshot) -> Advice{
        let advice = Advice()
        advice.title = (adviceSnapshot.childSnapshot(forPath: "title").value as? String)!
        advice.text = (adviceSnapshot.childSnapshot(forPath: "text").value as? String)!
        advice.number = (adviceSnapshot.childSnapshot(forPath: "number").value as? Int)!

        return advice
    }

}
