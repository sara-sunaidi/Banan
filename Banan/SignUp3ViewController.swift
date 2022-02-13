//
//  SignUp3ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit

class SignUp3ViewController: UIViewController {
    //var gg = SignUp1ViewController()
    var Sex : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func GIRL(_ sender: UIButton) {
        Sex = "Girl"
    }
    
    @IBAction func BOY(_ sender: UIButton) {
        Sex = "Boy"
    }
    @IBAction func SignUp4(_ sender: UIButton) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp4" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)*/
        performSegue(withIdentifier: "SignUp3To4", sender: self)

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
