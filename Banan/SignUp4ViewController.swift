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
//import FirebaseStorage

class SignUp4ViewController: UIViewController , UITextFieldDelegate {
    var em2 : String = ""
    var pass2 : String = ""
    var dob2 : String = ""
    var sex1 : String = ""
    var score : String = "٠"
    var name : String = ""
    
    let database = Firestore.firestore()
        
    @IBOutlet weak var Name: UITextField!
    
    // Get a reference to the storage service using the default Firebase App
    //let storage = Storage.storage()

       
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = name
        Name.layer.cornerRadius = 15.0
        Name.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        Name.delegate = self
        print(em2,pass2,dob2,sex1)

        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "SignUp4To3", sender: self)
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
        print(em2,pass2,dob2,sex1,Name.text)

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
            Auth.auth().createUser(withEmail: em2, password: pass2) { [self] authResult, error in
            if error == nil {
          // ...
            let uid = Auth.auth().currentUser?.uid
            self.writeData(id: uid ?? "error")
            
            self.performSegue(withIdentifier: "ToHomePage", sender: self)
            }
            else {
                let alert = UIAlertController(title: "تنبيه", message:"هذا المستخدم مسجل بالفعل \(self.em2)", preferredStyle: .alert)
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
        docref.setData(["Email": em2, "Name": Name.text, "DOB": dob2, "Gender": sex1, "Score": score])

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp4To3" {
            let destinationVC = segue.destination as? SignUp3ViewController
            destinationVC?.Sex = sex1
            destinationVC?.em1 = em2
            destinationVC?.pass1 = pass2
            destinationVC?.dob1 = dob2
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
