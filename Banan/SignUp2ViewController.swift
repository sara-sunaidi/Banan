//
//  SignUp2ViewController.swift
//  Banan
//
//  Created by Reema khalaf on 10/07/1443 AH.
//

import UIKit
import Foundation
//extension UIDatePicker
//{
//    /// set the date picker values and set min/max
//    /// - parameter date: Date to set the picker to
//    /// - parameter unit: (years, days, months, hours, minutes...)
//    /// - parameter deltaMinimum: minimum date delta in units
//    /// - parameter deltaMaximum: maximum date delta in units
//    /// - parameter animated: Whether or not to use animation for setting picker
//    func setDate(_ date:Date, unit:NSCalendar.Unit, deltaMinimum:Int, deltaMaximum:Int, animated:Bool)
//    {
//        setDate(date, animated: animated)
//
//        setMinMax(unit: unit, deltaMinimum: deltaMinimum, deltaMaximum: deltaMaximum)
//    }
//
//    /// set the min/max for the date picker (uses the pickers current date)
//    /// - parameter unit: (years, days, months, hours, minutes...)
//    /// - parameter deltaMinimum: minimum date delta in units
//    /// - parameter deltaMaximum: maximum date delta in units
//    func setMinMax(unit:NSCalendar.Unit, deltaMinimum:Int, deltaMaximum:Int)
//    {
//        if let gregorian = NSCalendar(calendarIdentifier:.gregorian)
//        {
//            if let minDate = gregorian.date(byAdding: unit, value: deltaMinimum, to: self.date)
//            {
//                minimumDate = minDate
//            }
//
//            if let maxDate = gregorian.date(byAdding: unit, value: deltaMaximum, to: self.date)
//            {
//                maximumDate = maxDate
//            }
//        }
//    }
//}
class SignUp2ViewController: UIViewController {
    var em : String = ""
    var pass : String = ""
    var dob : String = ""
   // var Dob1 : UIDatePicker? = nil
    var sex : String = ""
    var name : String = ""


   var date1 = Date()

    //let datepicker = UIDatePicker()

    @IBOutlet weak var DOB: UIDatePicker!
    
    //let he = SignUp1ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MMM dd, YYYY"
        let date = dateFormatter.date(from: dob)
        DOB.date = date ?? date1
       // DOB?.setValue(Dob1)
//        DOB.setDate(date, unit:.year, deltaMinimum:-80, deltaMaximum:-6, animated: true)
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
        performSegue(withIdentifier: "SignUp2To1", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        print("print \(sender.date)")

        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, YYYY"
        let somedateString = dateFormatter.string(from: sender.date)
        
        dob = somedateString

            print(somedateString)  // "somedateString" is your string date
    }
    
    
    
    @IBAction func SignUp3(_ sender: UIButton) {
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SignUp3" )
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated:  true)*/
        if dob == "" {
            let alert = UIAlertController(title: "تنبيه", message:"الرجاء ادخل تاريخ الميلاد", preferredStyle: .alert)
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
            performSegue(withIdentifier: "SignUp2To3", sender: self)

        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp2To3" {
            let destinationVC = segue.destination as? SignUp3ViewController
           // if let date = dob{
            destinationVC?.em1 = em
            destinationVC?.pass1 = pass
            destinationVC?.dob1 = dob
            destinationVC?.Sex = sex
            destinationVC?.name = name

          //  destinationVC?.Dob = DOB


            //}
            
            }
        else {
            if segue.identifier == "SignUp2To1" {
                let destinationVC = segue.destination as? SignUp1ViewController
                destinationVC?.email = em
                destinationVC?.password = pass
                destinationVC?.dob = dob
                destinationVC?.sex = sex
                destinationVC?.name = name


   
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
