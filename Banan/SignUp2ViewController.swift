//
//  SignUp2ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit
import Foundation

class SignUp2ViewController: UIViewController {
    
    static var sharedInstance:SignUp2ViewController?

    var email : String = ""
    var password : String = ""
    var dob : String = ""
    var sex : String = ""
    var name : String = ""

    var date1 = Date()

    @IBOutlet weak var submit: UIButton!

    @IBOutlet weak var DOB: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SignUp2ViewController.sharedInstance = self

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
        dateFormatter.dateFormat =  "MMM dd, YYYY"
     
        let date = dateFormatter.date(from: dob)
        DOB.date = date ?? date1
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
        comps.year = -6
        comps.month = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -80
        let minDate = calendar.date(byAdding: comps, to: Date())

        DOB.maximumDate = maxDate
        DOB.minimumDate = minDate
        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: Any) {
        dismissVC()
        self.dismiss(animated: true, completion: nil)
    }
    func dismissVC(){
        SignUp1ViewController.sharedInstance?.email = email
        SignUp1ViewController.sharedInstance?.password = password
        SignUp1ViewController.sharedInstance?.dob = dob
        SignUp1ViewController.sharedInstance?.sex = sex
        SignUp1ViewController.sharedInstance?.name = name

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        print("print \(sender.date)")

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
            dateFormatter.dateFormat = "MMM dd, YYYY"
        
        let somedateString = dateFormatter.string(from: sender.date)
        
        dob = somedateString

            print(somedateString)  // "somedateString" is your string date
    }
    
    
    
    @IBAction func SignUp3(_ sender: UIButton) {
  
        if dob == "" {
            CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء إدخال تاريخ الميلاد", acknowledgementType: .negative)       }
        else{
            performSegue(withIdentifier: "SignUp2To3", sender: self)

        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp2To3" {
            let destinationVC = segue.destination as? SignUp3ViewController
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
