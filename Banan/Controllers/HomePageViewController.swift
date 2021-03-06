//
//  HomePageViewController.swift
//  Banan
//
//  Created by Reema khalaf on 28/07/1443 AH.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import Firebase
//import AVFoundation


class HomePageViewController : UIViewController{
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var instructions: UIButton!
    @IBOutlet weak var dashBoard: UIButton!
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var points: UILabel!
    var Profile : String = ""
    var Score : String = ""
    
    var allLetters = [Letters]()
    var allWords = [Words]()

    var lettersCount = Int()
    var wordsCount = Int()
    var completedLetters = [String]()
    var completedWords = [String]()
//    var player: AVAudioPlayer?
//    let db = Firestore.firestore()
    override func viewDidAppear(_ animated: Bool) {
        getChildData()
        
        var canOpenCamera = takePhotoVC.checkCameraPermissions()
//        UserDefaults.standard.set(canOpenCamera, forKey: "canOpenCamera")

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.tintColor = UIColor.white
        dashBoard.tintColor = UIColor.white
        instructions.tintColor = UIColor.white
        dashBoard.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        dashBoard.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        dashBoard.layer.shadowOpacity = 0.8
        dashBoard.layer.shadowRadius = 0.0
        dashBoard.layer.masksToBounds = false
        
        instructions.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        instructions.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        instructions.layer.shadowOpacity = 0.8
        instructions.layer.shadowRadius = 0.0
        instructions.layer.masksToBounds = false
        getChildData()
        getLettersData()
        getWordsData()

    }
    
    func getLettersData(){
        let letter = LocalStorage.allLettersInfo
        if letter != nil{
            allLetters = letter!
        }
    }
    
    func getWordsData(){
        let word = LocalStorage.allWordsInfo
        if word != nil{
            allWords = word!
        }
    }
    // Get child object from local storage
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }
        
    }
    
    func setChildInfo(child: Child){
        self.completedLetters = child.completedLetters
        
        self.completedWords = child.completedWords
        
        self.name.text = child.name
        let allPoints = child.GameLevels.map({Int(($0["UserPoints"] ?? "0")) ?? 0}).reduce(0, +)
        
        self.points.text = "\(allPoints)".convertedDigitsToLocale(Locale(identifier: "AR"))
//        "\(child.score)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let Profile = child.gender
        
        if Profile == "Boy"{
            self.profileImage.configuration? .background.image = UIImage(named: "boy3.png")
            //profileImage.setImage(UIImage(named: "boy123.png"), for: .normal)
           // profileImage.image = UIImage(named: "boy123.png")
        }
        else {
            self.profileImage.configuration? .background.image = UIImage(named: "girl3.png")
            //profileImage.setImage(UIImage(named:"girl123.png"), for:.normal)
            //profileImage.image = UIImage(named: "girl123.png")
        }
        
//        let viewInstruction = UserDefaults.standard.bool(forKey: "viewInstruction")
//        print("eeeeeeeeeeeeeee")
//        print(viewInstruction)
//        if(!viewInstruction){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "HomeInstructions") as! HomeInstructionsViewController
//            view.window?.rootViewController = controller
//            view.window?.makeKeyAndVisible()
//        }
//
    }
    
    @IBAction func pressInstructions(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeInstructions") as! HomeInstructionsViewController
        view.window?.rootViewController = controller
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func pressLearn(_ sender: UIButton) {
        playSound("Practice")
//        PlayAllSounds.sharedInstance.stop()
//        PlayAllSounds.sharedInstance.play(name: "Practice")
        performSegue(withIdentifier: "GoToLearningPage", sender: self)
        
    }
    @IBAction func profilePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToProfile", sender: self)    }
    
    @IBAction func pressGame(_ sender: UIButton) {
        playSound("Game")
//        PlayAllSounds.sharedInstance.stop()
//        PlayAllSounds.sharedInstance.play(name: "Game")
        performSegue(withIdentifier: "GoToGameLevels", sender: self)
        
        }
    @IBAction func pressDashBoard(_ sender: Any) {
        performSegue(withIdentifier: "GoToDashBoard", sender: self)

    }
    func playSound(_ name: String){
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: name)
    }
}
