//
//  WordViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
//

import UIKit

//// Protocol in UIView Class for navigation purposes
//protocol WordViewControllerDelegate {
//    func didCheck()
//}

var wordVC = WordViewController()

class WordViewController: UIViewController, UINavigationControllerDelegate, CustomAlertViewControllerDelegate, CustomConfirmationViewControllerDelegate {
    
    static let instance = WordViewController()
    
    //    var delegate: WordViewControllerDelegate?
    
    @IBOutlet weak var speakerBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempImgView: UIImageView!
    var newImage: UIImage!
    
    var expectedResult : String? // Store currrent word in here
    
    override func viewDidLoad() {
        print("## in view load WORD")
        super.viewDidLoad()
        CustomAlertViewController.instance.delegate = self
        CustomConfirmationViewController.instance.delegate = self
        if(newImage == nil){
            print("### Nil")
        }else{
            print("### NOT Nil")
            //            imageView.image = newImage
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("result"), object: nil)
        
        // start session
        
    }
    @objc func didGetNotification(_ notification:Notification){
        let result = notification.object as! String?
        //        tempImgView.image = image
        checkAnswer(result!)
    }
    
    
    @IBAction func checkAnswerBtn(_ sender: Any) {
        // # check answer method call
        print("## in Check")
        takePhotoVC.checkCameraPermissions()
        let timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            takePhotoVC.didTapCheck()
        }
        
    }
    
    //    func setImage (_ i:UIImage){
    //        self.imageView.image = i
    //
    //    }
    
    private func checkAnswer(_ actualResult: String){
        
        print("## in CheckAnswer")
        
        expectedResult = "بنان" // # set with the comming values
        print("##### actualResult is \(actualResult)")
        if (actualResult != ""){
            print("## in CheckAnswer IF")
            if (actualResult == expectedResult){
                // Correct Answer
                correctAnswer()
            }else if (actualResult == "UnDetermined"){
                // show fix paper message
                let viewModel: SnackbarViewModel
                
                viewModel = SnackbarViewModel(text: "رجاءً تأكد من وضع القطع في مكانها الصحيح !", image: UIImage(named: "Warning"))
                
                let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
                let snackbar = SnackbarView(viewModel: viewModel, frame: frame, color: .yellow)
                showSnackbar(snackbar: snackbar)
                
            }else{
                // Incorrect Answer
                
                // Snackbar calling is here
                let viewModel: SnackbarViewModel
                
                viewModel = SnackbarViewModel(text: "إجابة خاطئة..حاول مرة أخرى!", image: UIImage(named: "wrongAnswer"))
                
                let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
                let snackbar = SnackbarView(viewModel: viewModel, frame: frame, color: .red)
                showSnackbar(snackbar: snackbar)
            }
        }
        
    }
    
    private func correctAnswer(){
        
        // Call pop up
        CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
        
        // # update user info
    }
    
    @IBAction func onClickPreWord(_ sender: Any) {
        // # navigate to pre word
        // call alert dialog
        
    }
    @IBAction func onClickExit(_ sender: Any) {
        print("### in original exit btn")
        //        self.dismiss(animated: true, completion: nil)
        //        performSegue(withIdentifier: "ToWord", sender: self)
        CustomConfirmationViewController.instance.showAlert(title: "تنبيه", message: "هل تود الخروج من الكلمة الحالية؟")
    }
    @IBAction func onClickSpeaker(_ sender: Any) {
        // # play audio
        CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "اختبار للاكنولجمنت النيقاتيف", acknowledgementType: .negative)
    }
    
    @IBAction func onClickGuide(_ sender: Any) {
        // # will be implemented in Group3
        
        //        CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "اختبار للاكنولجمنت البوستف", acknowledgementType: .positive)
        
        
    }
    
    
    
    // The coming three methods to handle correct answer pop-up actions
    
    func didContinueButtonTapped() {
        print("Continue tapped in word controller")
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
        
        // # update the completed words list
    }
    func didRedoButtonTapped() {
        print("Redo tapped in word controller")
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
        
        // # display the letter page again with the same index
    }
    func didExitButtonTapped() {
        print("Exit tapped in word controller")
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    // The coming method to handle exit confirmation pop-up actions
    
    func didYesButtonTapped() {
        print("Yes tapped in word controller")
        self.dismiss(animated: true, completion: nil)
    }
    
    func showSnackbar(snackbar: SnackbarView){
        
        let width = view.frame.size.width/1.5
        
        // set frame to start position
        snackbar.frame = CGRect(
            x: (view.frame.size.width-width)/2,
            y: view.frame.size.height,
            width: width,
            height: 130)
        
        view.addSubview(snackbar)
        
        // animate it upwards
        UIView.animate(withDuration: 0.5, animations: {
            snackbar.frame = CGRect(
                x: (self.view.frame.size.width-width)/2,
                y: self.view.frame.size.height - 140,
                width: width,
                height: 130)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    
                    // animate it downwards
                    UIView.animate(withDuration: 0.5, animations: {
                        snackbar.frame = CGRect(
                            x: (self.view.frame.size.width-width)/2,
                            y: self.view.frame.size.height,
                            width: width,
                            height: 130)
                    }, completion: { finished in
                        if finished{
                            snackbar.removeFromSuperview()
                        }
                        
                    })
                })
                
                
            }
        })
    }
    
}






