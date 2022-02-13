//
//  SignUp1ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 09/07/1443 AH.
//

import UIKit

class SignUp1ViewController: UIViewController {


    @IBOutlet weak var Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Next(_ sender: UIButton) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp2" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)*/
        if Email.text == "" {
            print("enter your email")
        }
        else{
        performSegue(withIdentifier: "SignUp1To2", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp1To2" {
            let destinationVC = segue.destination as? SignUp2ViewController
            if let ema = Email.text{
            destinationVC?.em = ema
            }
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
