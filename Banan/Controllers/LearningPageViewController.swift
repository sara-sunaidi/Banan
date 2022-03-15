//
//  LearningPageViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 14/03/2022.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import Firebase

class LearningPageViewController: UIViewController {

    //not passed
    var allLetters = [String]()
    
    //passed
    var completedLetters: [String]?
    var completedWords: [String]?
    
    var allLettersCount = Int()
    var allWordsCount = Int()
    
    let db = Firestore.firestore()
    
//    //passed
//    var letterPercent: Float?
//    var wordPercent: Float?

    @IBOutlet weak var letterButton: UIButton!
    
    @IBOutlet weak var wordButton: UIButton!
    
    @IBOutlet weak var letterLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        print("1")
//        db.collection("Letters").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                //self.getAllLetters(dbSnapshot: querySnapshot)
//                print("2")
////                self.allLetters = [String]()
//                for document in querySnapshot!.documents {
//                    self.allLetters.append(document.documentID)
//
//                }
//                }
////
//        }
        
        if let userId = Auth.auth().currentUser?.uid {
                let collectionRef = self.db.collection("Children")
                let thisUserDoc = collectionRef.document(userId)
            
            print("3")

            thisUserDoc.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    self.completedLetters = [String]()
                    //self.completedLevels = dataDescription?["CompletedLevel"] as! [String]
                    self.completedLetters = dataDescription?["CompletedLetter"] as? [String]
                    self.completedWords = dataDescription?["CompletedWord"] as? [String]
                    
                } else {
                    print("Document does not exist")
                }
                print("4")
                self.designButtons()

            }
        }
    }
    func designButtons(){
        letterLabel.text = "\(completedLetters?.count ?? 0) من الحروف تم دراستها".convertedDigitsToLocale(Locale(identifier: "AR"))
        print("pp")
        print(completedWords)
        print(completedWords?.count)
        wordLabel.text = "\(completedWords?.count ?? 0) من الكلمات تم دراستها".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        letterButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        letterButton.layer.shadowOffset = CGSize(width: 0.0,height: 3.0)
        letterButton.layer.shadowOpacity = 0.8
        letterButton.layer.shadowRadius = 0.0
        letterButton.layer.masksToBounds = false
        
        
        wordButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        wordButton.layer.shadowOffset = CGSize(width: 0.0,height: 3.0)
        wordButton.layer.shadowOpacity = 0.8
        wordButton.layer.shadowRadius = 0.0
        wordButton.layer.masksToBounds = false
    }
//    func getAllLetters (dbSnapshot: QuerySnapshot?){
//
//        print(dbSnapshot!.documents.count)
//
//                for document in dbSnapshot!.documents {
//                    self.allLetters.append(document.documentID)
//
//                }
//
//            }
//    }
    
//    func assignPercent(){
//        print("5")
//        letterPercent = Float(completedLetters!.count)/Float(allLetters!.count)
//        print(letterPercent)
//    }
    
    @IBSegueAction func GoToCircleBar(_ coder: NSCoder) -> UIViewController? {
        print("6")
        let letterPercent = Float(completedLetters!.count)/Float(allLettersCount)
        
        return UIHostingController(coder: coder, rootView: CircularProgressView(passedVal: letterPercent).background(Color(red: 205 / 255, green: 202 / 255, blue: 216 / 255)))
    }
    
    @IBSegueAction func GoToCircularBar2(_ coder: NSCoder) -> UIViewController? {
        print("7")
        let wordPercent = Float(completedWords!.count)/Float(allWordsCount)
        return UIHostingController(coder: coder, rootView: CircularProgressView(passedVal: wordPercent).background(Color(red: 237 / 255, green: 213 / 255, blue: 141 / 255)))
    }
    
    @IBAction func pressBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func pressLearnLetters(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToLearnLettersPage", sender: self)
    }
    
}
