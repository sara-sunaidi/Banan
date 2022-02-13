//
//  SignUp2ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit

class SignUp2ViewController: UIViewController {
    var em : String = ""
//let he = SignUp1ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(em)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DOB(_ sender: UIDatePicker) {
    }
    
    @IBAction func SignUp3(_ sender: UIButton) {
        print(em)
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp3" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)*/
        performSegue(withIdentifier: "SignUp2To3", sender: self)

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
