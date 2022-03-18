//
//  ResetPasswordViewController.swift
//  Banan
//
//  Created by Shaden Al on 10/08/1443 AH.
//
import UIKit
import Firebase
import SwiftUI
class ResetPasswordViewController : UIViewController{
    var oldPass : String = ""
    var newPass : String = ""
    @IBOutlet weak var oldTriangle: UIButton!
    @IBOutlet weak var oldGreen123: UIButton!
    @IBOutlet weak var oldStar123: UIButton!
    @IBOutlet weak var oldRed123: UIButton!
    @IBOutlet weak var oldParallelogram: UIButton!
    @IBOutlet weak var oldCircle: UIButton!
    @IBOutlet weak var newTriangle: UIButton!
    @IBOutlet weak var newGreen123: UIButton!
    @IBOutlet weak var newStar123: UIButton!
    @IBOutlet weak var newRed123: UIButton!
    @IBOutlet weak var newParallelogram: UIButton!
    @IBOutlet weak var newCircle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        oldTriangle.tintColor = UIColor.white
        oldGreen123.tintColor = UIColor.white
        oldStar123.tintColor = UIColor.white
        oldRed123.tintColor = UIColor.white
        oldParallelogram.tintColor = UIColor.white
        oldCircle.tintColor = UIColor.white
        newTriangle.tintColor = UIColor.white
        newGreen123.tintColor = UIColor.white
        newStar123.tintColor = UIColor.white
        newRed123.tintColor = UIColor.white
        newParallelogram.tintColor = UIColor.white
        newCircle.tintColor = UIColor.white
    }
    @IBAction func oldTriangle(_ sender: UIButton) {
        oldPass = "triangle"
        selectoldButton(sender)
    }
    @IBAction func oldGreen123(_ sender: UIButton) {
        oldPass = "green123"
        selectoldButton(sender)
    }
    
    @IBAction func oldStar123(_ sender: UIButton) {
        oldPass = "star123"
        selectoldButton(sender)
    }
    
    @IBAction func oldRed123(_ sender: UIButton) {
        oldPass = "red123"
        selectoldButton(sender)
    }
    
    @IBAction func oldParallelogram(_ sender: UIButton) {
        oldPass = "parallelogram"
        selectoldButton(sender)
    }
    @IBAction func oldCircle(_ sender: UIButton) {
        oldPass = "circle"
        selectoldButton(sender)
    }
    @IBAction func newTriangle(_ sender: UIButton) {
        newPass = "triangle"
        selectNewButton(sender)
    }
    @IBAction func newGreen123(_ sender: UIButton) {
        newPass = "green123"
        selectNewButton(sender)
    }
    @IBAction func newStar123(_ sender: UIButton) {
        newPass = "star123"
        selectNewButton(sender)
    }
    @IBAction func newRed123(_ sender: UIButton) {
        newPass = "red123"
        selectNewButton(sender)
    }
    
    @IBAction func newParallelogram(_ sender: UIButton) {
        newPass = "parallelogram"
        selectNewButton(sender)
    }
    @IBAction func newCircle(_ sender: UIButton) {
        newPass = "circle"
        selectNewButton(sender)
    }
    func selectoldButton(_ sender: UIButton){
        deSelectOldButton()
        sender.tintColor = UIColor.systemGray
    }
    func deSelectOldButton(){
        oldTriangle.tintColor = UIColor.white
        oldGreen123.tintColor = UIColor.white
        oldStar123.tintColor = UIColor.white
        oldRed123.tintColor = UIColor.white
        oldParallelogram.tintColor = UIColor.white
        oldCircle.tintColor = UIColor.white
    }
    func selectNewButton(_ sender: UIButton){
        deSelectNewButton()
        sender.tintColor = UIColor.systemGray
    }
    func deSelectNewButton(){
        newTriangle.tintColor = UIColor.white
        newGreen123.tintColor = UIColor.white
        newStar123.tintColor = UIColor.white
        newRed123.tintColor = UIColor.white
        newParallelogram.tintColor = UIColor.white
        newCircle.tintColor = UIColor.white
    }
    @IBAction func updatePassword(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        var credential: AuthCredential
         credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: oldPass)
        if self.oldPass != ""{
            if self.newPass != "" {
                if self.oldPass != self.newPass {
         if user != nil{
            user?.reauthenticate(with: credential){authResult, error in
                if let e = error{
                    self.errorAlert("لم تنجح عملية تغير كلمة المرور")
                }else{
                  
                       
                            
                                Auth.auth().currentUser?.updatePassword(to: self.newPass)
                    let alert = UIAlertController(title: "تأكيد", message: "تم تغير كلمة المرور بنجاح", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                            case .default:
                            print("default")
                            self.performSegue(withIdentifier: "GoToProfile", sender: self)
                            case .cancel:
                            print("cancel")
                            self.performSegue(withIdentifier: "GoToProfile", sender: self)
                            case .destructive:
                            print("destructive")
                            
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
               
                
           
                        }}}
        }else{
            self.errorAlert("الرجاء إدخال كلمة مرور جديدة مختلفة عن كلمة المرور السابقة")
        }
            }else {
                self.errorAlert(" الرجاء إدخال كلمة المرور الجديدة")
            }
            }else {
           self.errorAlert(" الرجاء إدخال كلمة المرور السابقة")
       }
        
    }
    
    func errorAlert (_ e : String){
        let alert = UIAlertController(title: "تنبيه", message: e, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    
}
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToProfile", sender: self)
    }
}
