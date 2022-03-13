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
    var third = [[String: Any]]()
    var fourth = [[String: Any]]()
    var fifth = [[String: Any]]()
    var sixth = [[String: Any]]()
    var seventh = [[String: Any]]()
    var eighth = [[String: Any]]()
    var ninth = [[String: Any]]()
    var tenth = [[String: Any]]()

    
    var chosenLevel = [[String: Any]]()
    var levelTitle : String?
    var completedLevels = [String]()
    var completedLetters = [String]()
    
    //buttons
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    @IBOutlet weak var seventhButton: UIButton!
    @IBOutlet weak var eighthButton: UIButton!
    @IBOutlet weak var ninthButton: UIButton!
    @IBOutlet weak var tenthButton: UIButton!
    
    
    //labels
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLable: UILabel!
    @IBOutlet weak var sixthLable: UILabel!
    @IBOutlet weak var seventhLable: UILabel!
    @IBOutlet weak var eighthLable: UILabel!
    @IBOutlet weak var ninthLable: UILabel!    
    @IBOutlet weak var tenthLable: UILabel!
    
    
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
        
        designButton(completed: completedLevels.contains("Third"), levelArray: third, label: thirdLabel, button: thirdButton)
        
        designButton(completed: completedLevels.contains("Fourth"), levelArray: fourth, label: fourthLabel, button: fourthButton)
        
        designButton(completed: completedLevels.contains("Fifth"), levelArray: fifth, label: fifthLable
                     , button: fifthButton)
        
        designButton(completed: completedLevels.contains("Sixth"), levelArray: sixth, label: sixthLable, button: sixthButton)
        
        designButton(completed: completedLevels.contains("Seventh"), levelArray: seventh, label: seventhLable, button: seventhButton)
        
        designButton(completed: completedLevels.contains("Eighth"), levelArray: eighth, label: eighthLable, button: eighthButton)
        
        designButton(completed: completedLevels.contains("Ninth"), levelArray: ninth, label: ninthLable, button: ninthButton)
        
        designButton(completed: completedLevels.contains("Tenth"), levelArray: tenth, label: tenthLable, button: tenthButton)
       


    }
    
    
    func designButton(completed: Bool, levelArray: [[String : Any]], label: UILabel, button: UIButton){
        
        let filteredArray = levelArray.map{$0["Letter"]} as! [String]
        let intersect = Set(filteredArray).intersection(completedLetters).count
        
        //English num to Arabic num
        let arabicIntersect = "\(intersect)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let arabicTotal = "\(levelArray.count)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        if(completed){
            //green color
            button.backgroundColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }
        print("ar total:")
print(arabicTotal)
        print("inter se")
        print(arabicIntersect)
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
        third = allLetters.filter({$0["Level"] as! String == "Third"})
        fourth = allLetters.filter({$0["Level"] as! String == "Fourth"})
        fifth = allLetters.filter({$0["Level"] as! String == "Fifth"})
        sixth = allLetters.filter({$0["Level"] as! String == "Sixth"})
        seventh = allLetters.filter({$0["Level"] as! String == "Seventh"})
        eighth = allLetters.filter({$0["Level"] as! String == "Eighth"})
        ninth = allLetters.filter({$0["Level"] as! String == "Ninth"})
        tenth = allLetters.filter({$0["Level"] as! String == "Tenth"})

        }
        
    
    @IBAction func pressBack(_ sender: UIButton) {
        //performSegue(withIdentifier: "GoToHomePage", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func levelPressed(_ sender: UIButton) {
        switch sender{
        case firstButton:
            print("ggg")
            chosenLevel = first
//            levelTitle = "المستوى الثاني"
            print("in first")
            levelTitle = "المستوى الأول"
            break;
            
        case secondButton:
            chosenLevel = second
            levelTitle = "المستوى الثاني"
            print("in second")
            break;
        
        case thirdButton:
            chosenLevel = third
            levelTitle = "المستوى الثالث"
            print("in third")
            break;
            
        case fourthButton:
            chosenLevel = fourth
            levelTitle = "المستوى الرابع"
            print("in fourth")
            break;
            
        case fifthButton:
            chosenLevel = fifth
            levelTitle = "المستوى الخامس"
            print("in fifth")
            break;
            
        case sixthButton:
            chosenLevel = sixth
            levelTitle = "المستوى السادس"
            print("in sixth")
            break;
            
        case seventhButton:
            chosenLevel = seventh
            levelTitle = "المستوى السابع"
            print("in seventh")
            break;
            
        case eighthButton:
            chosenLevel = eighth
            levelTitle = "المستوى الثامن"
            print("in eighth")
            break;
            
        case ninthButton:
            chosenLevel = ninth
            levelTitle = "المستوى التاسع"
            print("in ninth")
            break;
            
        case tenthButton:
            chosenLevel = tenth
            levelTitle = "المستوى العاشر"
            print("in tenth")
            break;
            
        default:
            print("select another btn level")
        }
        if(chosenLevel.count == 2){
        self.performSegue(withIdentifier: "GoToLetters2", sender: self)
        }
        else if( chosenLevel.count == 3){
            self.performSegue(withIdentifier: "GoToLetters3", sender: self)
        }
        else if(chosenLevel.count == 4){
            self.performSegue(withIdentifier: "GoToLetters4", sender: self)
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // do the same for all three views
        
        if segue.identifier == "GoToLetters2"{
            let destination = segue.destination as! Letters2ViewController
            destination.letters = chosenLevel
            destination.completedLetters = completedLetters
            destination.levelTitle = levelTitle
        }
        
        else if segue.identifier == "GoToLetters3"{
            let destination = segue.destination as! Letters3ViewController
            destination.letters = chosenLevel
            destination.completedLetters = completedLetters
            destination.levelTitle = levelTitle
        }
        
        else if segue.identifier == "GoToLetters4"{
            let destination = segue.destination as! Letters4ViewController
            destination.letters = chosenLevel
            destination.completedLetters = completedLetters
            destination.levelTitle = levelTitle
        }
    }

}
