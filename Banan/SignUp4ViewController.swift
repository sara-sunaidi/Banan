//
//  SignUp4ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit
import Firebase


class SignUp4ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func CreateAccount(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: "reemakd326@gmail.com", password: "123456") { authResult, error in
          // ...
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
