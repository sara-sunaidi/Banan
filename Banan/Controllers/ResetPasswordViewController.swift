//
//  ResetPasswordViewController.swift
//  Banan
//
//  Created by Reema khalaf on 17/08/1443 AH.
//

import UIKit

class ResetPasswordViewController : UIViewController ,CustomAcknowledgementViewControllerDelegate {
    var flag :Bool = false
    var isValid = true

    var oldPass : String = ""
    var newPass : String = ""
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var oldTriangle: UIButton!
    @IBOutlet weak var oldGreen123: UIButton!
    @IBOutlet weak var oldStar123: UIButton!
    @IBOutlet weak var oldRed123: UIButton!
    @IBOutlet weak var oldParallelogram: UIButton!
    @IBOutlet weak var oldCircle: UIButton!
    @IBOutlet weak var newTriangle: UIButton!
    @IBOutlet weak var newGreen123: UIButton!
    @IBOutlet weak var newStar123: UIButton!
    @IBOutlet weak var newRed123: UIButton!
    @IBOutlet weak var newParallelogram: UIButton!
    @IBOutlet weak var newCircle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        flag = false
        isValid = false

        CustomAcknowledgementViewController.instance.delegate = self
        saveButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        saveButton.layer.shadowOpacity = 0.8
        saveButton.layer.shadowRadius = 0.0
        saveButton.layer.masksToBounds = false
        oldTriangle.tintColor = UIColor.white
        oldGreen123.tintColor = UIColor.white
        oldStar123.tintColor = UIColor.white
        oldRed123.tintColor = UIColor.white
        oldParallelogram.tintColor = UIColor.white
        oldCircle.tintColor = UIColor.white
        newTriangle.tintColor = UIColor.white
        newGreen123.tintColor = UIColor.white
        newStar123.tintColor = UIColor.white
        newRed123.tintColor = UIColor.white
        newParallelogram.tintColor = UIColor.white
        newCircle.tintColor = UIColor.white
    }
    @IBAction func oldTriangle(_ sender: UIButton) {
        oldPass = "triangle"
        selectoldButton(sender)
    }
    @IBAction func oldGreen123(_ sender: UIButton) {
        oldPass = "green123"
        selectoldButton(sender)
    }
    
    @IBAction func oldStar123(_ sender: UIButton) {
        oldPass = "star123"
        selectoldButton(sender)
    }
    
    @IBAction func oldRed123(_ sender: UIButton) {
        oldPass = "red123"
        selectoldButton(sender)
    }
    
    @IBAction func oldParallelogram(_ sender: UIButton) {
        oldPass = "parallelogram"
        selectoldButton(sender)
    }
    @IBAction func oldCircle(_ sender: UIButton) {
        oldPass = "circle"
        selectoldButton(sender)
    }
    @IBAction func newTriangle(_ sender: UIButton) {
        newPass = "triangle"
        selectNewButton(sender)
    }
    @IBAction func newGreen123(_ sender: UIButton) {
        newPass = "green123"
        selectNewButton(sender)
    }
    @IBAction func newStar123(_ sender: UIButton) {
        newPass = "star123"
        selectNewButton(sender)
    }
    @IBAction func newRed123(_ sender: UIButton) {
        newPass = "red123"
        selectNewButton(sender)
    }
    
    @IBAction func newParallelogram(_ sender: UIButton) {
        newPass = "parallelogram"
        selectNewButton(sender)
    }
    @IBAction func newCircle(_ sender: UIButton) {
        newPass = "circle"
        selectNewButton(sender)
    }
    func selectoldButton(_ sender: UIButton){
        deSelectOldButton()
        sender.tintColor = UIColor.systemGray3
    }
    func deSelectOldButton(){
        oldTriangle.tintColor = UIColor.white
        oldGreen123.tintColor = UIColor.white
        oldStar123.tintColor = UIColor.white
        oldRed123.tintColor = UIColor.white
        oldParallelogram.tintColor = UIColor.white
        oldCircle.tintColor = UIColor.white
    }
    func selectNewButton(_ sender: UIButton){
        deSelectNewButton()
        sender.tintColor = UIColor.systemGray3
    }
    func deSelectNewButton(){
        newTriangle.tintColor = UIColor.white
        newGreen123.tintColor = UIColor.white
        newStar123.tintColor = UIColor.white
        newRed123.tintColor = UIColor.white
        newParallelogram.tintColor = UIColor.white
        newCircle.tintColor = UIColor.white
    }
    @IBAction func updatePassword(_ sender: UIButton) {
        
        if(oldPass == ""){
            self.errorAlert(" الرجاء إدخال كلمة المرور السابقة")
            return
        }
        if(newPass == ""){
            self.errorAlert(" الرجاء إدخال كلمة المرور الجديدة")
            return
        }
        if(self.oldPass == self.newPass){
            self.errorAlert("الرجاء إدخال كلمة مرور جديدة مختلفة عن كلمة المرور السابقة")
            return
        }
        isValid = true
        //when resetPassword methode done, resetProcessDone will start
        FirebaseRequest.resetPassword(oldPass: oldPass, newPass: newPass,completion: resetProcessDone(_:_:))
        
    }
    
    func resetProcessDone(_ data:Bool, _ error:Error?) -> Void {
        if(data){
            self.flag = true
            CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "تم تغير كلمة المرور بنجاح" , acknowledgementType: .positive)
        }else{
            self.flag = false
            self.errorAlert("لم تنجح عملية تغير كلمة المرور هناك مشكلة")
        }
    }
    
    func errorAlert (_ e : String){
     CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: e , acknowledgementType: .negative)
}
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func didDoneButtonTapped(){
        if flag  {
            self.dismiss(animated: true, completion: nil)}
    }
}
