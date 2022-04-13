//
//  ViewProfileViewController.swift
//  Banan
//
//  Created by Reema khalaf on 17/08/1443 AH.
//

import UIKit
import Firebase
import SwiftUI
class ViewProfileViewController : UIViewController{
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var resetPassword: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var logOut: UIButton!
    var calcAge = 0
    var current = 0
    var currentYear = 0
    var Dob = 0
    var date : String = ""
    var formatter = NumberFormatter()

    let db = Firestore.firestore()
    override func viewDidAppear(_ animated: Bool) {
        getChildData()
        viewDidLoad()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPassword.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        resetPassword.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        resetPassword.layer.shadowOpacity = 0.8
        resetPassword.layer.shadowRadius = 0.0
        resetPassword.layer.masksToBounds = false
        logOut.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        logOut.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        logOut.layer.shadowOpacity = 0.8
        logOut.layer.shadowRadius = 0.0
        logOut.layer.masksToBounds = false

        
    }
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }
        
    }
    func setChildInfo(child: Child){
        self.email.text = child.email
        self.name.text = child.name
        let date = child.DOB
        let Profile = child.gender
        let currentYear = Int(Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year! )
      
        let Dob = Int(date.suffix(4))
        let calcAge = currentYear - Dob!
        if calcAge > 10 {
        self.formatter.locale = Locale(identifier: "ar")
            self.age.text = self.formatter.string(from: NSNumber(value: calcAge ) )! + " سنة"}
        else {  self.formatter.locale = Locale(identifier: "ar")
            self.age.text = self.formatter.string(from: NSNumber(value: calcAge ) )! + " سنوات"}

        if Profile == "Boy"{
            self.profileImage.configuration? .background.image = UIImage(named: "boy1.png")
           
        }
        else {
            self.profileImage.configuration? .background.image = UIImage(named: "girl1.png")
            
        }
        
        
    }
    @IBAction func ressetPasswordPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToResetPassword", sender: self)
    }
    @IBAction func LogOutPressed(_ sender: UIButton) {
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
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
//        self.performSegue(withIdentifier: "GoToHomePage", sender: self)
    }
    @IBAction func editProfilePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToEditProfile", sender: self)
    }
}

