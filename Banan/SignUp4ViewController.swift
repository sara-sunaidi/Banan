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

extension String {
    var filter: String {
        return String(unicodeScalars.filter(CharacterSet.letters.contains))
    }
}

class SignUp4ViewController: UIViewController , UITextFieldDelegate {
    var email : String = ""
    var password : String = ""
    var dob : String = ""
    var sex : String = ""
//    var score : String = "0"
    var name : String = ""
    var isValid = false
    let database = Firestore.firestore()
    
    @IBOutlet weak var submit: UIButton!

    @IBOutlet weak var Name: UITextField!

    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.isHidden = true
        loading.hidesWhenStopped = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        isValid = false
        Name.text = name
        Name.layer.cornerRadius = 15.0
        Name.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        Name.delegate = self

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        Name.text = Name.text?.filter
        
        loading.isHidden = false
        loading.startAnimating()

        if Name.text == "" {
            loading.stopAnimating()
            CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء إدخال الاسم", acknowledgementType: .negative)      }
        else{
            isValid = true
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                if let e = error{
        
                    print(e)
                    if let errorCode = AuthErrorCode(rawValue: error!._code) {
                        loading.stopAnimating()
                        switch errorCode {
                                                
                            case .emailAlreadyInUse:
                              CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "هذا المستخدم مسجل بالفعل \(email)", acknowledgementType: .negative)
                                               
                                break
                            case .networkError:
                              CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء التحقق من الاتصال بالانترنت", acknowledgementType: .negative)
                                break
                                                
                            @unknown default:
                              CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "حدث خطأ! حاول مجددا", acknowledgementType: .negative)
                                                
                                break
                                            }
                                        }
                }
                else {
          // ...
            let uid = Auth.auth().currentUser?.uid
            self.writeData(id: uid ?? "error")
                
                    loading.stopAnimating()

                    
//                    let viewInstruction = UserDefaults.standard.bool(forKey: "viewInstruction")
//                    print("eeeeeeeeeeeeeee")
//                    print(viewInstruction)
//                    if(!viewInstruction){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "HomeInstructions") as! HomeInstructionsViewController
                        view.window?.rootViewController = controller
                        view.window?.makeKeyAndVisible()
//                    }
                    
//            self.performSegue(withIdentifier: "ToHomePage", sender: self)
            }
        }
        }

    }
    
    func writeData(id: String){
        let docref = database.document("Children/\(id)")
        docref.setData(["Email": email, "Name": Name.text, "DOB": dob, "Gender": sex, "GameLevels": [[String: String]](),
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
