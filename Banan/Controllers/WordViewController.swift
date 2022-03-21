//
//  WordViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
//

import UIKit

// Protocol in UIView Class for navigation purposes
protocol WordViewControllerDelegate {
    func didCheckTapped()
}


class WordViewController: UIViewController, CustomAlertViewControllerDelegate, CustomConfirmationViewControllerDelegate {
    
    static let instance = WordViewController()
    
    @IBOutlet weak var speakerBtn: UIButton!
    
    var delegate: WordViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomAlertViewController.instance.delegate = self
        CustomConfirmationViewController.instance.delegate = self
        
        
    }
    @IBAction func checkAnswerBtn(_ sender: Any) {
        // # check answer method call
        delegate?.didCheckTapped()
        // call alert dialog
//        CustomAlertViewController.instance.showAlert(title: "أحسنت !", message: "لقد أجبت إجابة صحيحة", alertType: .word)
        
    }
    
    @IBAction func onClickPreWord(_ sender: Any) {
        // # navigate to pre word
        // call alert dialog
        CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
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
        
                // Snackbar calling is here
                let viewModel: SnackbarViewModel
        
                viewModel = SnackbarViewModel(text: "إجابة خاطئة..حاول مرة أخرى!", image: UIImage(named: "wrongAnswer"))
        
                let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
                let snackbar = SnackbarView(viewModel: viewModel, frame: frame)
                showSnackbar(snackbar: snackbar)
    }
    
    public func showSnackbar(snackbar: SnackbarView){
        
        let width = view.frame.size.width/1.5
        
        // set frame to start position
        snackbar.frame = CGRect(
            x: (view.frame.size.width-width)/2,
            y: view.frame.size.height,
            width: width,
            height: 140)
        
        view.addSubview(snackbar)
        
        // animate it upwards
        UIView.animate(withDuration: 0.5, animations: {
            snackbar.frame = CGRect(
                x: (self.view.frame.size.width-width)/2,
                y: self.view.frame.size.height - 150,
                width: width,
                height: 140)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    
                    // animate it downwards
                    UIView.animate(withDuration: 0.5, animations: {
                        snackbar.frame = CGRect(
                            x: (self.view.frame.size.width-width)/2,
                            y: self.view.frame.size.height,
                            width: width,
                            height: 140)
                    }, completion: { finished in
                        if finished{
                            snackbar.removeFromSuperview()
                        }
                        
                    })
                })
                
                
            }
        })
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
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
}




// Custom class for speaker and hind rounded buttons

final class CustomButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 50).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}
