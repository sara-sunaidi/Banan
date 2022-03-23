//
//  LogInViewController.swift
//  Banan
//
//  Created by Reema khalaf on 28/07/1443 AH.
//

import UIKit
import Firebase
import SwiftUI
class LogInViewContoller : UIViewController{
    var password : String=""
    @IBOutlet weak var triangle: UIButton!
    @IBOutlet weak var green123: UIButton!
    @IBOutlet weak var star123: UIButton!
    @IBOutlet weak var red123: UIButton!
    @IBOutlet weak var parallelogram: UIButton!
    @IBOutlet weak var circle: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var signUp: UIButton!
    var cheak : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextfield.layer.cornerRadius = 15.0
        triangle.tintColor = UIColor.white
        green123.tintColor = UIColor.white
        star123.tintColor = UIColor.white
        red123.tintColor = UIColor.white
        parallelogram.tintColor = UIColor.white
        circle.tintColor = UIColor.white
        signUp.setAttributedTitle("إنشاء الحساب".underlined, for: .normal)
    }
    @IBAction func trianglePass(_ sender: UIButton) {
        password = "triangle"
        selectButton(sender)
      
    }
    @IBAction func green123(_ sender: UIButton) {
        password = "green123"
        selectButton(sender)
    }
    
    @IBAction func star123(_ sender: UIButton) {
        password = "star123"
        selectButton(sender)
    }
    @IBAction func red123(_ sender: UIButton) {
        password = "red123"
        selectButton(sender)
    }
    @IBAction func parallelogram(_ sender: UIButton) {
        password = "parallelogram"
        selectButton(sender)
    }
    @IBAction func circle(_ sender: UIButton) {
        password = "circle"
        selectButton(sender)
    }
   
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if emailTextfield.text != ""{
            if cheak == false{
        if let email = emailTextfield.text,  password != "" {
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if let e = error{
    
                print(e)
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                        
                    switch errorCode {
                                            
                                        case .userNotFound:
                                            self.errorAlert("البريد الالكتروني غير مسجل")
                                            break
                                        case .networkError:
                                            self.errorAlert( "فضلًا تحقق من اتصالك بالانترنت")
                                            break
                                            
                                        @unknown default:
                                            self.errorAlert("البريد الالكتروني او كلمة المرور غير صحيحة")
                                            break
                                        }
                                    }
//                self.errorAlert("البريد الالكتروني او كلمة المرور غير صحيحة")
            }
            else {
                
                self.performSegue(withIdentifier: "GoToHomePage", sender: self)
            }
        }} else{
            errorAlert("الرجاء إدخال كلمة المرور")
            
        }}else {
            errorAlert("الرجاء إدخال البريد الالكتروني بشكل صحيح")
//            emailError.text = "الرجاء إدخال البريد الالكتروني بشكل صحسح"
      
            
        }
          // ...
        }else {
            errorAlert("الرجاء إدخال البريد الالكتروني")
           
            
        }
    }
    func invalidEmail(_ value: String) -> String? {
          let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
          if !predicate.evaluate(with: value)
          {
              return "الرجاء إدخال البريد الالكتروني بشكل صحيح"
          }
          return nil
      }
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTextfield.text {
                    if let errorMessage = invalidEmail(email) {
                        errorLabel.text = errorMessage
                        errorLabel.isHidden = false
                        cheak = true
                    }
                    else {
                        errorLabel.isHidden = true
                        cheak = false
                    }
                }
            }
    
    //    func isValidEmail(_ email: String?) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailPred.evaluate(with: email)
//    }
    
    func selectButton(_ sender: UIButton){
        deSelectButton()
        sender.tintColor = UIColor.systemGray3
    }
    func deSelectButton(){
        triangle.tintColor = UIColor.white
        green123.tintColor = UIColor.white
        star123.tintColor = UIColor.white
        red123.tintColor = UIColor.white
        parallelogram.tintColor = UIColor.white
        circle.tintColor = UIColor.white
    }
    @IBAction func BackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func errorAlert (_ e : String){
//        let alert = UIAlertController(title: "تنبيه", message: e, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            switch action.style{
//                case .default:
//                print("default")
//
//                case .cancel:
//                print("cancel")
//
//                case .destructive:
//                print("destructive")
//
//            }
//        }))
//        self.present(alert, animated: true, completion: nil)
        CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: e ,acknowledgementType: .negative)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToSignUp", sender: self)
    }
}


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


