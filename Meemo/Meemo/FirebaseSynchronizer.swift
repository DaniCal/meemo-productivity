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
        
        let sessions = lectureSnapshot.childSnapshot(forPath: "sessions")
        let enumerator = sessions.children

        while let session = enumerator.nextObject() as? FIRDataSnapshot{
            lecture.sessions.append(parseSession(session))
        }
        
        return lecture
    }
    
    static func parseSession(_ sessionSnapshot: FIRDataSnapshot)->Session{
        let session = Session()
        session.title = (sessionSnapshot.childSnapshot(forPath: "title").value as? String)!
        session.url = (sessionSnapshot.childSnapshot(forPath: "url").value as? String)!
        session.duration = (sessionSnapshot.childSnapshot(forPath: "duration").value as? Int)!
        return session
    }
    
    
    
    
//    static func parseDailyPushup(dailyPushUpShot: FIRDataSnapshot)->DailyPushUp{
//
//        let dailyPushUp = DailyPushUp()
//        
//        dailyPushUp.author = (dailyPushUpShot.childSnapshot(forPath: "author").value as? String)!
//        dailyPushUp.biography = (dailyPushUpShot.childSnapshot(forPath: "biography").value as? String)!
//        dailyPushUp.desc = (dailyPushUpShot.childSnapshot(forPath: "description").value as? String)!
//        dailyPushUp.file = (dailyPushUpShot.childSnapshot(forPath: "file").value as? String)!
//        dailyPushUp.pictureOverview = (dailyPushUpShot.childSnapshot(forPath: "pictureOverview").value as? String)!
//        dailyPushUp.picturePlayer = (dailyPushUpShot.childSnapshot(forPath: "picturePlayer").value as? String)!
//        dailyPushUp.readMore = (dailyPushUpShot.childSnapshot(forPath: "readMore").value as? String)!
//        dailyPushUp.time = (dailyPushUpShot.childSnapshot(forPath: "time").value as? String)!
//        dailyPushUp.title = (dailyPushUpShot.childSnapshot(forPath: "title").value as? String)!
//        
//        return dailyPushUp
//    }
//    
//    
//    static func parseProgram(programShot: FIRDataSnapshot)-> Program{
//        
//        let program = Program()
//        
//        program.title = (programShot.childSnapshot(forPath: "title").value as? String)!
//        program.teaser = (programShot.childSnapshot(forPath: "teaser").value as? String)!
//        program.subtitle = (programShot.childSnapshot(forPath: "subtitle").value as? String)!
//        program.descr = (programShot.childSnapshot(forPath: "description").value as? String)!
//        program.pictureOverview = (programShot.childSnapshot(forPath: "pictureOverview").value as? String)!
//        program.pictureSquare = (programShot.childSnapshot(forPath: "pictureSquare").value as? String)!
//        program.picturePlayer = (programShot.childSnapshot(forPath: "picturePlayer").value as? String)!
//        
//        let sessions = programShot.childSnapshot(forPath: "sessions")
//        
//        let enumerator = sessions.children
//        while let sessionShot = enumerator.nextObject() as? FIRDataSnapshot {
//            program.sessions.append(parseSession(sessionShot: sessionShot))
//        }
//        return program
//    }
//    
//    
//    static func parseSession(sessionShot: FIRDataSnapshot)->Session{
//        
//        let session = Session()
//        
//        session.author = (sessionShot.childSnapshot(forPath: "author").value as? String)!
//        session.biography = (sessionShot.childSnapshot(forPath: "biography").value as? String)!
//        session.desc = (sessionShot.childSnapshot(forPath: "description").value as? String)!
//        session.file = (sessionShot.childSnapshot(forPath: "file").value as? String)!
//        session.readMore = (sessionShot.childSnapshot(forPath: "readMore").value as? String)!
//        session.time = (sessionShot.childSnapshot(forPath: "time").value as? String)!
//        session.title = (sessionShot.childSnapshot(forPath: "title").value as? String)!
//        return session
//    }
}
