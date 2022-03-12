//
//  LetterLevelsViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 07/03/2022.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import Firebase

class LevelsViewController: UIViewController {

    
    let db = Firestore.firestore()
    
    var allLetters = [[String: Any]]()
    
    //levels
    var first = [[String: Any]]()
    var second = [[String: Any]]()
    //...
    
    var chosenLevel = [[String: Any]]()
    
    var completedLevels = [String]()
    var completedLetters = [String]()
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    //...
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    //...
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if let userId = Auth.auth().currentUser?.uid {
                let collectionRef = self.db.collection("Children")
                let thisUserDoc = collectionRef.document(userId)

            thisUserDoc.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    
                    self.completedLevels = dataDescription?["CompletedLevel"] as! [String]
                    self.completedLetters = dataDescription?["CompletedLetter"] as! [String]
                    
                } else {
                    Swift.print("Document does not exist")
                }
                self.buttonLevels()
            }
        }

        db.collection("Letters").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.groupByLevel(dbSnapshot: querySnapshot)
                }
//
        }
        }
    
    func buttonLevels(){
        
        designButton(completed: completedLevels.contains("First"), levelArray: first, label: firstLabel, button: firstButton)
        designButton(completed: completedLevels.contains("Second"), levelArray: second, label: secondLabel, button: secondButton)
        //...


    }
    
    
    func designButton(completed: Bool, levelArray: [[String : Any]], label: UILabel, button: UIButton){
        
        let filteredArray = levelArray.map{$0["Letter"]} as! [String]
        let intersect = Set(filteredArray).intersection(completedLetters).count
        
        //English num to Arabic num
        let arabicIntersect = "\(intersect)".convertedDigitsToLocale(Locale(identifier: "FA"))
        let arabicTotal = "\(levelArray.count)".convertedDigitsToLocale(Locale(identifier: "FA"))
        
        if(completed){
            //green color
            button.backgroundColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }

        label.text = "\(arabicTotal)/\(arabicIntersect) من الأحرف تم دراستها"
        button.layer.cornerRadius = 30
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
    }
    
    
    func groupByLevel(dbSnapshot: QuerySnapshot?) {
            print(dbSnapshot!.documents.count)
            
            for document in dbSnapshot!.documents {
                var dat = document.data()
                dat["Letter"] = document.documentID
                dat["Image"] = UIImage (named: "\(document.documentID)Pic.png")
                
                self.allLetters.append(dat)
                
            }
        
        first = allLetters.filter({$0["Level"] as! String == "First"})
        second = allLetters.filter({$0["Level"] as! String == "Second"})
        //...
        }
        
    
    @IBAction func pressBack(_ sender: UIButton) {
        //performSegue(withIdentifier: "GoToHomePage", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func levelPressed(_ sender: UIButton) {
        switch sender{
        case firstButton:
            chosenLevel = first
            print("in first")
            break;
            
        case secondButton:
            chosenLevel = second
            print("in second")
            break;
        //...
        default:
            print("select another btn level")
        }
        if(chosenLevel.count == 2){
        self.performSegue(withIdentifier: "GoToLetters", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // do the same for all three views
        if segue.identifier == "GoToLetters"{
            let destination = segue.destination as! LettersViewController
            destination.letters = chosenLevel
            destination.completedLetters = completedLetters
        }
    }

}
