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
    
    var allLetters = [String]()
    var lettersCount = Int()
    var wordsCount = Int()
    var completedLetters = [String]()
    var completedWords = [String]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userId = Auth.auth().currentUser?.uid {
                let collectionRef = self.db.collection("Children")
                let thisUserDoc = collectionRef.document(userId)
                thisUserDoc.getDocument(completion: { document, error in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    if let doc = document {
                        let dataDescription = doc.data()
                        self.completedLetters = dataDescription?["CompletedLetter"] as! [String]
                        self.completedWords = dataDescription?["CompletedWord"] as! [String]
                        
                        self.name.text =  doc.get("Name") as? String
                        self.points.text = doc.get("Score") as? String
                        let Profile = doc.get("Gender") as? String
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
                })
            }
        
        db.collection("Letters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //self.getAllLetters(dbSnapshot: querySnapshot)
                print("2")
                self.lettersCount = querySnapshot?.documents.count ?? 0
//                for document in querySnapshot!.documents {
//                    self.allLetters.append(document.documentID)
//
//                }
                }
    //
        }
        
        db.collection("Words").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                //self.getAllLetters(dbSnapshot: querySnapshot)
                print("2")
                self.wordsCount = querySnapshot?.documents.count ?? 0
//                for document in querySnapshot!.documents {
//                    self.allLetters.append(document.documentID)
//
//                }
                }
    //
        }

//            if let userId = Auth.auth().currentUser?.uid {
//                print("gggggg")
//                print(userId)
//            var userName = db.collection("Children").getDocuments() { (snapshot, error) in
//                if let error = error {
//                    print("dddddddddd")
//            } else {
//                //do something
//                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
//                    let Name = currentUserDoc["Name"] as! String
//
//                }
//                        }
//                    }
//                }
            
//        var ref: DatabaseReference!
//
//        ref = Database.database().reference()
//        if let Uid = uid{
//            ref.child("Children").child(Uid).getData { error, <#DataSnapshot#> in
//                if error == nil{
//
//                }
//                <#code#>
//            }}
//        if let userId = uid {
//           let docRef = db.collection("Children").document(userId)}
//        print(docRef)
        
//        db.collection("Children").getDocuments { querySnapshot, error in
//            if let e = error{
//
//            }else{
//
//            }
//
//            <#code#>
//        }
       // name.text = Name
      
        // Do any additional setup after loading the view.
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // do the same for all three views
        
        if segue.identifier == "GoToLearningPage"{
            let destination = segue.destination as! LearningPageViewController
            print("tteesstt")
//            print(Float(completedLetters.count)/Float(lettersCount))
//            destination.letterPercent = Float(completedLetters.count)/Float(lettersCount)
//            destination.wordPercent = Float(completedWords.count)/Float(wordsCount)
            destination.allLettersCount = lettersCount
            destination.allWordsCount = wordsCount
            destination.completedWords = completedWords
//            destination.allLetters = allLetters
            destination.completedLetters = completedLetters
        }
    }
    @IBAction func pressLearn(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToLearningPage", sender: self)
        
    }
    @IBAction func profilePressed(_ sender: UIButton) {
        //print("gggggg")
    }
}
