//
//  AppDelegate.swift
//  Banan
//
//  Created by Sara Alsunaidi on 24/01/2022.
//

import UIKit
import Firebase
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var isChild : Bool = true
    var orientationLock = UIInterfaceOrientationMask.portrait
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let storage = Storage.storage()
        //let db = Firebase.firestore()
//        UserDefaults.standard.register(defaults: ["viewInstruction" : false])
        self.fetchLettersInfo()
        self.fetchWordsInfo()
        self.fetchGameInfo()
        
        //Auto Login
        _ = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {

                //Fetch user data
                self.fetchUserInfo()
                UserDefaults.standard.set(true, forKey: "isLogged")
//                UserDefaults.standard.set(false, forKey: "viewInstruction")

                //                Set is logged in child to true
//                animatedSplashVC.isChild = true


            } else {
                print("user not exist ")
                UserDefaults.standard.set(false, forKey: "isLogged")

//                Set is logged in child to false
//                animatedSplashVC.isChild = false
            }
        }
        UIWindow(frame: UIScreen.main.bounds)

        return true
    }
    
    // lock screen to single orientation
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
    
    func fetchGameInfo(){
            FirebaseRequest.setDBListenerGame(completion: fetchGame(_:_:))
        }
        
        func fetchGame(_ data:Any?, _ error:Error?) -> Void {

            if let data = data as? [Game]{
                
                LocalStorage.allGameInfo = data

            }else{
                print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
            }
        }
    
    
    func fetchWordsInfo(){
        FirebaseRequest.setDBListenerWords(completion: fetchWords(_:_:))
    }
    func fetchWords(_ data:Any?, _ error:Error?) -> Void {

        if let data = data as? [Words]{
            
                LocalStorage.allWordsInfo = data

        }else{
            print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
        }
    }
    func fetchLettersInfo(){
        FirebaseRequest.setDBListenerLetters(completion: fetchLetters(_:_:))
    }
    
    func fetchLetters(_ data:Any?, _ error:Error?) -> Void {

        if let data = data as? [Letters]{
            
                LocalStorage.allLettersInfo = data
            
        }else{
            print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
        }
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func fetchUserInfo(){
        FirebaseRequest.setDBListener(completion: fetchChildChangesoHandler(_:_:))
    }
    
    func fetchChildChangesoHandler(_ data:Any?, _ error:Error?) -> Void {

        if let data = data as? [String:Any]{
            do{
                //Convert data to type Child
                let child = Child(
                    DOB: data["DOB"] as! String,
                    completedLetters: data["CompletedLetter"] as! [String],
                    completedWords: data["CompletedWord"] as! [String],
                    completedLevels: data["CompletedLevel"] as! [String] ,
                    completedCategories: data["CompletedCategory"] as! [String],
                    GameLevels: data["GameLevels"] as? [[String: String]] ?? [["0":"0"]]  ,
                    email: data["Email"] as! String,
                    name: data["Name"] as! String,
//                    score: data["Score"] as! String,
                    gender: data["Gender"] as! String)

                //Store child object in local storage
                LocalStorage.childValue = child
            }catch{
                print("error while decoding ",error.localizedDescription)
            }
            
        }else{
            print("error!! App delagate - No data passed",error?.localizedDescription ?? "error localized Description" )
        }
    }
}

