//
//  HomeInstructionsViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 27/04/2022.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import Firebase
//import AVFoundation

class HomeInstructionsViewController: UIViewController {

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
    @IBOutlet weak var chat: UIImageView!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var dark: UIView!
    
    @IBOutlet weak var pointView: UIView!
    
    @IBOutlet weak var practiceBtn: UIButton!
    
    
    var instructionsText = [String]()
    var instructionsView = [UIView]()

    
    @IBOutlet weak var startInstructionBtn: UIButton!
    @IBOutlet weak var prevInstructionBtn: UIButton!
    @IBOutlet weak var nextInstructionBtn: UIButton!

    var index = 0
    override func viewDidAppear(_ animated: Bool) {
            getChildData()
        }
    
    @IBAction func skipInstructions(_ sender: UIButton) {
//                    view.sendSubviewToBack(profileImage)
        view.insertSubview(profileImage, belowSubview: dark)
//        view.insertSubview(profileImage, aboveSubview: profileImage)
//        (_:aboveSubview:)

    }
    func showInstruction(){
        instructionLabel.text = instructionsText[index]
        view.bringSubviewToFront(instructionsView[index])
        if(index == 0 ){
            startInstructionBtn.isHidden = false
            nextInstructionBtn.isHidden = true
            prevInstructionBtn.isHidden = true
            view.insertSubview(instructionsView[index+1], belowSubview: dark)
        }else if(index == instructionsView.count-1){
            startInstructionBtn.isHidden = true
            nextInstructionBtn.isHidden = false
            prevInstructionBtn.isHidden = false
            view.insertSubview(instructionsView[index-1], belowSubview: dark)
            }
        else{
            startInstructionBtn.isHidden = true
            nextInstructionBtn.isHidden = false
            prevInstructionBtn.isHidden = false
            view.insertSubview(instructionsView[index+1], belowSubview: dark)
            view.insertSubview(instructionsView[index-1], belowSubview: dark)

            
        }
//        index += 1

    }
    
    
    @IBAction func showPrevious(_ sender: UIButton) {
        index -= 1
        showInstruction()
        
    }
    
    @IBAction func showNext(_ sender: UIButton) {
        index += 1
        showInstruction()
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            instructionsText = ["أهلا بك في بنان!\n لنبدأ الرحلة...",
                                "من هنا تستطيع الوصول إلى صفحتك الشخصية",
            "مجموع النقاط يزداد بانتهائك من كل مستوى من اللعب",
                                "تدرب على الحروف والكلمات",
            
            ]
            
            instructionsView = [UIView(), profileImage, pointView, practiceBtn]
        showInstruction()
            
//            view.sendSubviewToBack(yourUIView)
//            view.bringSubviewToFront(profileImage)
//            view.bringSubviewToFront(chat)
//            instructionLabel.text = "من هنا تستطيع الوصول إلى صفحتك الشخصية"
            
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
                self.profileImage.configuration? .background.image = UIImage(named: "boy1.png")
                //profileImage.setImage(UIImage(named: "boy123.png"), for: .normal)
               // profileImage.image = UIImage(named: "boy123.png")
            }
            else {
                self.profileImage.configuration? .background.image = UIImage(named: "girl1.png")
                //profileImage.setImage(UIImage(named:"girl123.png"), for:.normal)
                //profileImage.image = UIImage(named: "girl123.png")
            }
            
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



