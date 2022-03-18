//
//  CustomAlertViewController.swift
//  Banan
//
//  Created by Madawi Ahmed

import Foundation
import UIKit
import SwiftUI

// Protocol in UIView Class for navigation purposes
protocol CustomAlertViewControllerDelegate {
    func didExitButtonTapped()
    func didContinueButtonTapped()
    func didRedoButtonTapped()
}

class CustomAlertViewController : UIView {
    
    static let instance = CustomAlertViewController()
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var redoBtn: CustomButton!
    @IBOutlet weak var continueBtn: CustomButton!
    @IBOutlet weak var exitBtn: CustomButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    
    var delegate: CustomAlertViewControllerDelegate?
    
    // enum to perform diffrent format/handlers for each alertType.
    enum AlertType {
        case word
        case letter
    }
    
    var currentAlertType: AlertType?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CustomAlertView", owner: self, options: nil)
        
        // img format
        img.layer.cornerRadius = img.bounds.size.width/2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 5
        
        // alert dialog format
        alertView.layer.cornerRadius = 50
        
        //Btns format (*Not Working need to be fixed*)
        continueBtn.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func showAlert(title: String, message: String, alertType: AlertType) {
        currentAlertType = alertType
        commonInit()
        
        self.title?.text = title
        self.message?.text = message
        
        switch alertType {
            
        case .word:
            img?.image = UIImage(named: "shinyStar")
            continueBtn?.setTitle("المتابعة للكلمة التالية", for: .normal)
            print("### in showAlert word")
            
        case .letter:
            img?.image = UIImage(named: "shinyStar")
            continueBtn?.setTitle("المتابعة للحرف التالي", for: .normal)
            print("### in showAlert letter")
            
        } // end switch
        
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
    @IBAction func onClickContinue(_ sender: Any) {
        print("### in continue btn ")
        parentView.removeFromSuperview()
        
        delegate?.didContinueButtonTapped()
    }
    
    @IBAction func onClickRedo(_ sender: Any) {
        print("### in redo btn ")
        parentView.removeFromSuperview()
        
        delegate?.didRedoButtonTapped()
    }
    @IBAction func onClickExit(_ sender: Any) {
        print("### in exit btn ")
        parentView.removeFromSuperview()
        
        // Diffrent handlers based on alertType (letter? or word?)
        //        switch currentAlertType {
        //
        //        case .word:
        //            print("### in exit btn > closed as WORD ")
        delegate?.didExitButtonTapped()
        
        
        //        case .letter:
        //            print("### in exit btn > closed as LETTER ")
        //            delegate?.didExitButtonTapped()
        
        //        case .none:
        //            //this case should never be excuted !
        //            print("### in exit btn > closed as NONE ")
        
        //        } // end switch
        
    }
}

/*
 custome .xib views based on https://letcreateanapp.com/2021/04/17/custom-alert-view-swift-4-xcode-11-1/
 */

/*
 Protocol in UIView Class for navigation purposes
 based on : -https://stackoverflow.com/questions/45936582/how-do-i-push-a-view-controller-from-a-uiview
 -https://stackoverflow.com/questions/51134557/how-to-move-from-uiview-to-uiviewcontroller-on-button-action
 */
