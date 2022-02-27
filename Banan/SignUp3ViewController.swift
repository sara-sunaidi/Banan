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
    var em1 : String = ""
    var pass1 : String = ""
    var dob1 : String = ""
    var name : String = ""
   // var Dob : UIDatePicker? = nil
    
    @IBOutlet weak var boy: UIButton!
    @IBOutlet weak var girl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boy.tintColor = UIColor.white
        girl.tintColor = UIColor.white
        switch (Sex){
        case "Girl":
            GIRL(girl)
        case "Boy":
            BOY(boy)
        default:
            Sex = ""
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "SignUp3To2", sender: self)
    }
    
    @IBAction func GIRL(_ sender: UIButton) {
        Sex = "Girl"
        selectButton(sender)
    }
    
    @IBAction func BOY(_ sender: UIButton) {
        Sex = "Boy"
        selectButton(sender)
    }
    
    func selectButton(_ sender: UIButton){
            deSelectButton()
            sender.tintColor = UIColor.systemGray3
        }
        func deSelectButton(){
            boy.tintColor = UIColor.white
            girl.tintColor = UIColor.white
            
        }
    
    @IBAction func SignUp4(_ sender: UIButton) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp4" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)*/
        if Sex == "" {
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
           // if let date = dob{
            destinationVC?.em2 = em1
            destinationVC?.pass2 = pass1
            destinationVC?.dob2 = dob1
            destinationVC?.sex1 = Sex
            destinationVC?.sex1 = Sex
            destinationVC?.name = name

            //}
            
            }
        else {
            if segue.identifier == "SignUp3To2" {
                let destinationVC = segue.destination as? SignUp2ViewController
               // if let date = dob{
                destinationVC?.dob = dob1
                destinationVC?.em = em1
                destinationVC?.pass = pass1
                destinationVC?.sex = Sex
                destinationVC?.name = name


        }
            
            
        }}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
