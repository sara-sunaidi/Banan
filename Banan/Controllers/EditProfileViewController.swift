//
//  EditProfileViewController.swift
//  Banan
//
//  Created by Shaden Al on 10/09/1443 AH.
//
import Firebase
import UIKit
import Foundation

class EditProfileViewController: UIViewController , UITextFieldDelegate ,CustomAcknowledgementViewControllerDelegate {

    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var boy: UIButton!
    @IBOutlet weak var girl: UIButton!
    @IBOutlet weak var DOB: UIDatePicker!
    var date1 = Date()
    var sex : String = ""
    var gender : String = ""
    var dob : String = ""
    var Dob : String = ""
    var currentyear : String = ""
    var year : String = ""
    var newName : String = ""
    var calcyear : String = ""
    var day = 0
    var currentday = 0
    var calcday = 0
    var monthAndDay : String = ""
    var calcAge = 0
    var currentMonth = 0
    var calcmonth = 0
    var month = 0
    var flag : Bool = false
    var checkMonth : Bool = false
    var checkDay : Bool = false
    @IBOutlet weak var name: UITextField!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        getChildData()
        CustomAcknowledgementViewController.instance.delegate = self
        let db = Firestore.firestore()
        let mycolor = UIColor.gray
        name.delegate = self
        name.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        name.layer.cornerRadius = 15.0
        name .layer.borderWidth = 1.0
        name.layer.borderColor = mycolor.cgColor
        girl.tintColor = UIColor.white
        boy.tintColor = UIColor.white
        save.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        save.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        save.layer.shadowOpacity = 0.8
        save.layer.shadowRadius = 0.0
        save.layer.masksToBounds = false


      
    }

       

    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }
        
    }
    func setChildInfo(child: Child){
        self.dob = child.DOB
        self.name.text = child.name
        self.gender = child.gender
        if gender == "Girl"{
            sex = "Girl"
            girl.configuration?.background.strokeColor = UIColor.systemYellow
            girl.tintColor = UIColor.systemGray3

        }else{
            sex = "Boy"
            boy.configuration?.background.strokeColor = UIColor.systemYellow
            boy.tintColor = UIColor.systemGray3

        }
        let dob = child.DOB
       // let Profile = doc.get("Gender") as? String
       let currentYear = Int(Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year! )
      
       // print(date)
        let year = Int(dob.suffix(4))
        let calcyear = currentYear - year!
        let calcAge = Int(calcyear)
        let monthAndDay = dob.prefix(5)
        let currentMonth = Int(monthAndDay.prefix(2))
        let currentday = Int(monthAndDay.suffix(2))

        let day =  Int(Calendar(identifier: .gregorian).dateComponents([.day], from: .now).day!)

        let calcday =  day - currentday!
       
        let month = Int(Calendar(identifier: .gregorian).dateComponents([.month], from: .now).month!)
        let calcmonth =  month - currentMonth!
          
        if calcAge > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "EN")
            dateFormatter.dateFormat =  "MM dd, YYYY"
         
            let date = dateFormatter.date(from: dob)
            DOB.date = date!
            let calendar = Calendar(identifier: .gregorian)
            var comps = DateComponents()
            if calcday < 0 {
                checkDay = true
            }
            if calcmonth < 0 {
                checkMonth = true
            }
            let calcday = abs(calcday)
          
            let calcmonth = abs(calcmonth)
            if checkDay{
                comps.day = +calcday
            }else{
                comps.day = -calcday
            }
            
            if checkMonth{
                comps.month = +calcmonth}
            else {
                comps.month = -calcmonth
            }
            comps.year = -calcAge
            let maxDate = calendar.date(byAdding: comps, to: Date())
            //comps.year = -80
         

            DOB.date = maxDate!
            print(dob)
        }}

   
    @IBAction func changedDate(_ sender: UIDatePicker) {
        
        let calendar = Calendar(identifier: .gregorian)
        var comps = DateComponents()
     
        
        comps.year = -6
        comps.month = 0
        let maxDate = calendar.date(byAdding: comps, to: Date())
        comps.year = -80
        let minDate = calendar.date(byAdding: comps, to: Date())

        DOB.maximumDate = maxDate
        DOB.minimumDate = minDate
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "EN")
            dateFormatter.dateFormat = "MM dd, YYYY"
        
        let somedateString = dateFormatter.string(from: sender.date)
        
        dob = somedateString
        print(dob)
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
    
    @IBAction func girlPressed(_ sender: UIButton) {
        sex = "Girl"
        selectButton(sender)
    }
    
    
    @IBAction func boyPressed(_ sender: UIButton) {
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
            boy.configuration?.background.strokeColor = UIColor.lightGray
            girl.configuration?.background.strokeColor = UIColor.lightGray
            
        }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        //self.performSegue(withIdentifier: "GoToProfile", sender: self)
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print("ddd",dob)
        print(name.text)
        if  name.text != ""{
            if dob != ""{
                flag = true
               let req = db.collection("Children").document(Auth.auth().currentUser!.uid)
                req.updateData(["Name":name.text])
                print("DOB",dob)
                req.updateData(["DOB":dob])
                req.updateData([ "Gender":sex])
                CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "تم تغيير المعلومات بنجاح" , acknowledgementType: .positive)
                
              
            } else {
                flag = false}
            
        } else {
            CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "الرجاء إدخال الاسم" ,acknowledgementType: .negative)
            flag = false}
        print(flag)
    }
    func didDoneButtonTapped(){
        if flag  {
            self.dismiss(animated: true, completion: nil)
//            self.performSegue(withIdentifier: "GoToProfile", sender: self)
        }}
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

