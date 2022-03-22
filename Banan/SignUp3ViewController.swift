//
//  SignUp3ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit

class SignUp3ViewController: UIViewController {

    static var sharedInstance:SignUp3ViewController?

    var sex : String = ""
    var email : String = ""
    var password : String = ""
    var dob : String = ""
    var name : String = ""
    
    @IBOutlet weak var boy: UIButton!
    @IBOutlet weak var girl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUp3ViewController.sharedInstance = self
        
        boy.tintColor = UIColor.white
        girl.tintColor = UIColor.white

        switch (sex){
        case "Girl":
            GIRL(girl)
        case "Boy":
            BOY(boy)
        default:
            sex = ""
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        dismissVC()
        self.dismiss(animated: true, completion: nil)
    }
    func dismissVC(){
        SignUp2ViewController.sharedInstance?.email = email
        SignUp2ViewController.sharedInstance?.password = password
        SignUp2ViewController.sharedInstance?.dob = dob
        SignUp2ViewController.sharedInstance?.sex = sex
        SignUp2ViewController.sharedInstance?.name = name

    }
    
    @IBAction func GIRL(_ sender: UIButton) {
        sex = "Girl"
        selectButton(sender)
    }
    
    @IBAction func BOY(_ sender: UIButton) {
        sex = "Boy"
        selectButton(sender)
      
    }
    
    func selectButton(_ sender: UIButton){
            deSelectButton()
            sender.tintColor = UIColor.systemGray3
        sender.configuration?.background.strokeColor = UIColor.systemYellow
        }
        func deSelectButton(){
            boy.tintColor = UIColor.white
            girl.tintColor = UIColor.white
            boy.configuration?.background.strokeColor = UIColor.white
            girl.configuration?.background.strokeColor = UIColor.white
            
        }
    
    @IBAction func SignUp4(_ sender: UIButton) {

        if sex == "" {
            let alert = UIAlertController(title: "تنبيه", message:"الرجاء اختيار شكل لتعيين الشخصية", preferredStyle: .alert)
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
        performSegue(withIdentifier: "SignUp3To4", sender: self)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp3To4" {
            let destinationVC = segue.destination as? SignUp4ViewController
            destinationVC?.email = email
            destinationVC?.password = password
            destinationVC?.dob = dob
            destinationVC?.sex = sex
            destinationVC?.name = name

            
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
