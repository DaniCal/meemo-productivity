//
//  AppDelegate.swift
//  Meemo
//
//  Created by Daniel Lohse on 5/22/17.
//  Copyright © 2017 Superstudio. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseInstanceID
import Alamofire
import Mixpanel



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FirebaseSynchornizeDelegate {

    var window: UIWindow?
    var lectures:[Lecture] = []
    var lecturesMO:[LectureMO] = []
    var loadedImages: Int = 0
    
    var mixpanel:Mixpanel!
    let mixpanelTestToken = "961d5f96adf20b0bb0a9096a9a524ffa"
    let mixpanelProductionToken = ""
    var mixpanelToken = "961d5f96adf20b0bb0a9096a9a524ffa"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initMixpanel()
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if(!launchedBefore){
            showOnboarding()
        }else{
            showLoadingScreen()
        }
        
        
        let context = persistentContainer.viewContext
        do{
            lecturesMO = try context.fetch(LectureMO.fetchRequest())
        }catch{
            print("Fetching failed!")
        }
        
        if(lecturesMO.count == 0){
            setUpData()
        }
        
        getData()
        
        FIRApp.configure()
        loadContentFromFB()
        return true
    }
    
    func initMixpanel(){
        self.mixpanelToken = self.mixpanelTestToken
        mixpanel = Mixpanel.sharedInstance(withToken: mixpanelToken)
        mixpanel.track("App launched")
        
    }
    
    func getData(){
        let context = persistentContainer.viewContext
        do{
            lecturesMO = try context.fetch(LectureMO.fetchRequest())
        }catch{
            print("Fetching failed!")
        }
        
        print(lecturesMO.count)
        print(lecturesMO[0].locked)
        print(lecturesMO[0].watched)
        print(lecturesMO[0].number)
        
        let sessionsMO = lecturesMO[0].sessions?.allObjects as! [SessionMO]
        
        print(sessionsMO[0].watched)
        print(sessionsMO[0].next)
        

        
    }
    
    func setUpData(){
        let context = self.persistentContainer.viewContext
        
        let lecture = LectureMO(context: context)
        lecture.number = 0
        lecture.watched = false
        lecture.locked = false
        
        let session = SessionMO(context: context)
        session.next = true
        session.watched = false
        session.number = 0
        
        lecture.addToSessions(session)
    
        self.saveContext()
    }
    
    
    
    func firebaseDidLoadLectures(_ lectures:[Lecture]){
        self.lectures = lectures
        loadImages()
    }
    
    
    func showLoadingScreen(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoadingScreen")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    func showOnboarding(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingPageViewController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

    }
    
    func showLecturesViewController(){
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LecturesViewController")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
    }
    

    
    func loadImages(){
        for lecture in lectures {
            loadImage(lecture: lecture)
        }
    }
    
    func loadImage(lecture: Lecture){
        Alamofire.request(lecture.imageURL).response { response in
            debugPrint(response)
            if let data = response.data {
                lecture.featuredImage = UIImage(data: data)!
            }else{
            }
            
            self.loadedImages = self.loadedImages + 1
            if(self.loadedImages >= self.lectures.count){
                let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
                if(launchedBefore){
                    self.showLecturesViewController()
                }

            }
            
        }
    }

    func loadContentFromFB(){
        FirebaseSynchronizer.delegate = self
        if(lectures.count == 0){
            FirebaseSynchronizer.subscribeToContent()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


}

