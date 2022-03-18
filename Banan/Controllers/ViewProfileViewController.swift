//
//  ViewProfileViewController.swift
//  Banan
//
//  Created by Shaden Al on 06/08/1443 AH.
//

import UIKit
import Firebase
import SwiftUI
class ViewProfileViewController : UIViewController{
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    var calcAge = 0
    var current = 0
    var currentYear = 0
    var Dob = 0
    var date : String = ""
    var formatter = NumberFormatter()

    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.email.text = Auth.auth().currentUser?.email
        if let userId = Auth.auth().currentUser?.uid {
                let collectionRef = self.db.collection("Children")
                let thisUserDoc = collectionRef.document(userId)
            thisUserDoc.getDocument(completion: { [self] document, error in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    if let doc = document {
                        self.name.text =  doc.get("Name") as? String
//                        self.points.text = doc.get("Score") as? String
                        let date = doc.get("DOB") as? String
                        let Profile = doc.get("Gender") as? String
                        let currentYear = Int(Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year! )
                      
                        print(date)
                        let Dob = Int(date!.suffix(4))
                        let calcAge = currentYear - Dob!
                     print(calcAge)
                        if calcAge > 10 {
                        self.formatter.locale = Locale(identifier: "ar")
                            self.age.text = self.formatter.string(from: NSNumber(value: calcAge ) )! + " سنه"}
                        else {  self.formatter.locale = Locale(identifier: "ar")
                            self.age.text = self.formatter.string(from: NSNumber(value: calcAge ) )! + " سنوات"}
                        //self.age.text = String(calcAge)
//                        let current = self.format.string(from: NSNumber(value: currentYear))
//                        print(current)
////                        self.formatter.dateFormat = "yyyy"
////                        self.formatter.locale = Locale(identifier: "ar")
////                        let currentYear = Int(self.formatter.string(from: .now))
//                        let  date =  doc.get("DOB") as? String
//                        print (date)
//                        let calcAge = date?.suffix(4) as! Int
//                        //print(calcAge)
////                       let Dob = self.format.string(from: NSNumber(value: calcAge ))
//                        print(calcAge)
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
                })
            }
        
    }
    @IBAction func ressetPasswordPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToResetPassword", sender: self)
    }
    @IBAction func LogOutPressed(_ sender: UIButton) {
     
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToHomePage", sender: self)
    }
}

