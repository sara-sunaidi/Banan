//
//  SignUp4ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import Foundation

class SignUp4ViewController: UIViewController , UITextFieldDelegate {
    var email : String = ""
    var password : String = ""
    var dob : String = ""
    var sex : String = ""
    var score : String = "0"
    var name : String = ""
    
    let database = Firestore.firestore()
        
    @IBOutlet weak var Name: UITextField!

       
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = name
        Name.layer.cornerRadius = 15.0
        Name.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        Name.delegate = self

    }
    @IBAction func backButton(_ sender: Any) {
        dismissVC()
        self.dismiss(animated: true, completion: nil)
    }
    func dismissVC(){
        SignUp3ViewController.sharedInstance?.email = email
        SignUp3ViewController.sharedInstance?.password = password
        SignUp3ViewController.sharedInstance?.dob = dob
        SignUp3ViewController.sharedInstance?.sex = sex
        SignUp3ViewController.sharedInstance?.name = Name.text ?? ""

    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let textFieldText = textField.text,
                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                    return false
            }
        let allowedCharacters = CharacterSet.letters
         let characterSet = CharacterSet(charactersIn: string)
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= 10 && allowedCharacters.isSuperset(of: characterSet)
        }
   

    @IBAction func CreateAccount(_ sender: UIButton) {

        if Name.text == "" {
            let alert = UIAlertController(title: "تنبيه", message:"الرجاء ادخال الاسم", preferredStyle: .alert)
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
                        self.present(alert, animated: true, completion: nil)        }
        else{
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if error == nil {
          // ...
            let uid = Auth.auth().currentUser?.uid
            self.writeData(id: uid ?? "error")
            
            self.performSegue(withIdentifier: "ToHomePage", sender: self)
            }
            else {
                let alert = UIAlertController(title: "تنبيه", message:"هذا المستخدم مسجل بالفعل \(self.email)", preferredStyle: .alert)
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
        }
        }

    }
    
    func writeData(id: String){
        let docref = database.document("Children/\(id)")
        docref.setData(["Email": email, "Name": Name.text, "DOB": dob, "Gender": sex, "Score": score,
                        "CompletedCategory": [String](), "CompletedLetter": [String](), "CompletedLevel": [String](), "CompletedWord": [String]()])

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp4To3" {
            let destinationVC = segue.destination as? SignUp3ViewController
            destinationVC?.email = email
            destinationVC?.password = password
            destinationVC?.dob = dob
            destinationVC?.sex = sex
            destinationVC?.name = Name.text ?? ""


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

}
