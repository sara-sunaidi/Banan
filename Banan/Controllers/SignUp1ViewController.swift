//
//  SignUp1ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 09/07/1443 AH.
//

import UIKit

class SignUp1ViewController: UIViewController, CustomConfirmationViewControllerDelegate {
    
    func didYesButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    static var sharedInstance:SignUp1ViewController?
    
    var password : String = ""
    var cheak : Bool = false
    var email : String = ""
    var dob : String = ""
    var sex : String = ""
    var name : String = ""

    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var triangle: UIButton!
    @IBOutlet weak var circle: UIButton!
    @IBOutlet weak var parallelogram: UIButton!
    @IBOutlet weak var flower: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        SignUp1ViewController.sharedInstance = self
        
        CustomConfirmationViewController.instance.delegate = self
        
        Email.layer.cornerRadius = 15.0
        
        triangle.tintColor = UIColor.white
        green.tintColor = UIColor.white
        star.tintColor = UIColor.white
        flower.tintColor = UIColor.white
        parallelogram.tintColor = UIColor.white
        circle.tintColor = UIColor.white
        
        Email.text? = email

        switch(password){
        case "star123":
            star(star)
        case "green123":
            green(green)
        case "triangle":
            triangle(triangle)
        case "circle":
            circle(circle)
        case "parallelogram":
            parallelogram(parallelogram)
        case "red123":
            flower(flower)
        default:
            password = ""
        }

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = Email.text {
            if let errorMessage = invalidEmail(email) {
                emailError.text = errorMessage
                emailError.isHidden = false
                cheak = true
            }
            else {
                emailError.isHidden = true
                cheak = false
            }
        }
    }
    func invalidEmail(_ value: String) -> String? {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return  "الرجاء إدخال البريد الإلكتروني بشكل صحيح"
        }
        return nil
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if Email.text == "" {
            self.dismiss(animated: true, completion: nil)
        }
        else {
        CustomConfirmationViewController.instance.showAlert(title: "تنبيه", message: "هل انت متأكد من الخروج؟ علما بانه لن يتم حفظ المعلومات المدخلة")
        }
    }
    @IBAction func star(_ sender: UIButton) {
        password = "star123"
        selectButton(sender)
    }
    @IBAction func green(_ sender: UIButton) {
        password = "green123"
        selectButton(sender)
    }
    @IBAction func triangle(_ sender: UIButton) {
        password = "triangle"
        selectButton(sender)
    }
    @IBAction func circle(_ sender: UIButton) {
        password = "circle"
        selectButton(sender)
    }
    @IBAction func parallelogram(_ sender: UIButton) {
        password = "parallelogram"
        selectButton(sender)
    }
    @IBAction func flower(_ sender: UIButton) {
        password = "red123"
        selectButton(sender)
    }
    
    func selectButton(_ sender: UIButton){
            deSelectButton()
            sender.tintColor = UIColor.systemGray3
        }
        func deSelectButton(){
            triangle.tintColor = UIColor.white
            green.tintColor = UIColor.white
            star.tintColor = UIColor.white
            flower.tintColor = UIColor.white
            parallelogram.tintColor = UIColor.white
            circle.tintColor = UIColor.white
        }

    @IBAction func Next(_ sender: UIButton) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp2" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)*/
        if Email.text == "" || password == "" || cheak == true{
            if Email.text == "" {
                CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء إدخال البريد الإلكتروني", acknowledgementType: .negative)
            }
            else {
            if cheak == true {
                CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء إدخال البريد الإلكتروني بشكل صحيح", acknowledgementType: .negative)
                }
            }
            if password == "" && Email.text != "" && cheak != true {
                CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء اختيار شكل لتعيين كلمة المرور", acknowledgementType: .negative)
            }
            
        }
                else{
                    emailError.isHidden = true

        performSegue(withIdentifier: "SignUp1To2", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp1To2" {
            let destinationVC = segue.destination as? SignUp2ViewController
            if let ema = Email.text{
            destinationVC?.email = ema
            destinationVC?.password = password
            destinationVC?.dob = dob
            destinationVC?.sex = sex
            destinationVC?.name = name

            }
            
            }
            
            
        }
    }
