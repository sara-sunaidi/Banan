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

class HomePageViewController : UIViewController{
    @IBOutlet weak var name: UILabel!
    
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
    
//    let db = Firestore.firestore()
    override func viewDidAppear(_ animated: Bool) {
        getChildData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.points.text = "\(child.score)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let Profile = child.gender
        
        if Profile == "Boy"{
            self.profileImage.configuration? .background.image = UIImage(named: "boy123.png")
            //profileImage.setImage(UIImage(named: "boy123.png"), for: .normal)
           // profileImage.image = UIImage(named: "boy123.png")
        }
        else {
            self.profileImage.configuration? .background.image = UIImage(named: "girl123.png")
            //profileImage.setImage(UIImage(named:"girl123.png"), for:.normal)
            //profileImage.image = UIImage(named: "girl123.png")
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "GoToLearningPage"{
//            let destination = segue.destination as! LearningPageViewController
//
//        }
//    }
    @IBAction func pressLogout(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "startPage" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)
        
        //added, need to test it
        LocalStorage.removeChild()
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    
    }
    
    @IBAction func pressLearn(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToLearningPage", sender: self)
        
    }
    @IBAction func profilePressed(_ sender: UIButton) {
        //print("gggggg")
    }
}
