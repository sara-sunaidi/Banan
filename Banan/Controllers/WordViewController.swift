//
//  WordViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
//

import UIKit

class WordViewController: UIViewController, CustomAlertViewControllerDelegate {
    
    static let instance = WordViewController()
    static let alertInstance = CustomAlertViewController.instance
    
    @IBOutlet weak var speakerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomAlertViewController.instance.delegate = self
            

    }
    @IBAction func checkAnswerBtn(_ sender: Any) {
        
        // call alert dialog

        CustomAlertViewController.instance.showAlert(title: "أحسنت !", message: "لقد أجبت إجابة صحيحة", alertType: .word)
       
    }
    
    @IBAction func onClickPreWord(_ sender: Any) {
        // call alert dialog
        CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
    }
    @IBAction func onClickExit(_ sender: Any) {
        print("### in original exit btn")
//        self.dismiss(animated: true, completion: nil)
//        performSegue(withIdentifier: "ToWord", sender: self)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "startPage") as! StartScreenViewController
        self.present(nextViewController, animated:true, completion:nil)
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
    
    
}

//extension WordViewController : CustomAlertViewControllerDelegate {
//
//    func didExitButtonTapped() {
//         print("Button tapped ")
//         self.ExitButtonTapped()
//    }

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
