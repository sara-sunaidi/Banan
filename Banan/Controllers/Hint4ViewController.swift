//
//  Hint4ViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 05/04/2022.
//
import Foundation
import UIKit
import SwiftUI

// Protocol in UIView Class for navigation purposes
protocol Hint4ViewControllerDelegate {
//    func didExitButtonTapped()
//    func didRedoButtonTapped()
}

class Hint4ViewController : UIView {
    
    static let instance = Hint4ViewController()
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
//    @IBOutlet weak var redoBtn: CustomButton!
    

    @IBOutlet weak var OkBtn: CustomButton!
    @IBOutlet weak var title: UILabel!

    
    @IBOutlet weak var cr1: UIButton!
    @IBOutlet weak var cr2: UIButton!
    @IBOutlet weak var cr3: UIButton!
    @IBOutlet weak var cr4: UIButton!
    @IBOutlet weak var cr5: UIButton!
    @IBOutlet weak var cr6: UIButton!
    
    //---
    
    @IBOutlet weak var cr11: UIButton!
    @IBOutlet weak var cr22: UIButton!
    @IBOutlet weak var cr33: UIButton!
    @IBOutlet weak var cr44: UIButton!
    @IBOutlet weak var cr55: UIButton!
    @IBOutlet weak var cr66: UIButton!
    
    //----
    
    @IBOutlet weak var cr111: UIButton!
    @IBOutlet weak var cr222: UIButton!
    @IBOutlet weak var cr333: UIButton!
    @IBOutlet weak var cr444: UIButton!
    @IBOutlet weak var cr555: UIButton!
    @IBOutlet weak var cr666: UIButton!
    
    //----
    
    @IBOutlet weak var cr1111: UIButton!
    @IBOutlet weak var cr2222: UIButton!
    @IBOutlet weak var cr3333: UIButton!
    @IBOutlet weak var cr4444: UIButton!
    @IBOutlet weak var cr5555: UIButton!
    @IBOutlet weak var cr6666: UIButton!
    
    //----
    
//    @IBOutlet weak var cr11111: UIButton!
//    @IBOutlet weak var cr22222: UIButton!
//    @IBOutlet weak var cr33333: UIButton!
//    @IBOutlet weak var cr44444: UIButton!
//    @IBOutlet weak var cr55555: UIButton!
//    @IBOutlet weak var cr66666: UIButton!
    
    @IBOutlet weak var block1: UIView!
    @IBOutlet weak var block2: UIView!
    @IBOutlet weak var block3: UIView!
    @IBOutlet weak var block4: UIView!
//    @IBOutlet weak var block5: UIView!
    
    var delegate: Hint4ViewControllerDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("Hint4View", owner: self, options: nil)
        
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("Hint4View", owner: self, options: nil)
        
        // img format
        img.layer.cornerRadius = img.bounds.size.width/2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 2
        
        // alert dialog format
        alertView.layer.cornerRadius = 50
        
        //Btns format (*Not Working need to be fixed*)
//        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        block1.layer.cornerRadius = 10
        block2.layer.cornerRadius = 10
        block3.layer.cornerRadius = 10
        block4.layer.cornerRadius = 10
//        block5.layer.cornerRadius = 10
        
    }
    func setBraille(_ c1:UIButton,_ c2:UIButton, _ c3:UIButton, _ c4:UIButton, _ c5:UIButton, _ c6:UIButton,_ letterBraille:String){
        addShadow(circle :c1)
        addShadow(circle :c2)
        addShadow(circle :c3)
        addShadow(circle :c4)
        addShadow(circle :c5)
        addShadow(circle :c6)

        for (i,s) in letterBraille.enumerated() {
            
            if(s=="1"){
                if(i==0){
                    c1.backgroundColor = UIColor(named: "Color1")
                    c1.layer.borderWidth = 4
                    c1.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==1){
                    c2.backgroundColor = UIColor(named: "Color1")
                    c2.layer.borderWidth = 4
                    c2.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==2){
                    c3.backgroundColor = UIColor(named: "Color1")
                    c3.layer.borderWidth = 4
                    c3.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==3){
                    c4.backgroundColor = UIColor(named: "Color1")
                    c4.layer.borderWidth = 4
                    c4.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==4){
                    c5.backgroundColor = UIColor(named: "Color1")
                    c5.layer.borderWidth = 4
                    c5.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                else{
                    c6.backgroundColor = UIColor(named: "Color1")
                    c6.layer.borderWidth = 4
                    c6.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
            }
        }
    }
    func showAlert(title: String, brailleArray: [String]) {
//        currentAlertType = alertType
        commonInit()
        print("count of braille array:")
        print(brailleArray.count)
        self.title?.text = title

        img?.image = UIImage(named: "hint")

        
        setBraille(cr1,cr2,cr3,cr4,cr5,cr6,brailleArray[0])
        setBraille(cr11,cr22,cr33,cr44,cr55,cr66,brailleArray[1])
        setBraille(cr111,cr222,cr333,cr444,cr555,cr666,brailleArray[2])
        setBraille(cr1111,cr2222,cr3333,cr4444,cr5555,cr6666,brailleArray[3])
//        setBraille(cr11111,cr22222,cr33333,cr44444,cr55555,cr66666,brailleArray[4])
//            continueBtn?.setTitle("المتابعة للكلمة التالية", for: .normal)
//            print("### in showAlert word")
//
////        case .letter:
//            img?.image = UIImage(named: "shinyStar")
//            continueBtn?.setTitle("المتابعة للحرف التالي", for: .normal)
//            print("### in showAlert letter")
            
//        } // end switch
        
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
//    func returnArabicNum( num: Int) -> String{
//        let arabicNum = "\(num)".convertedDigitsToLocale(Locale(identifier: "AR"))
//
//        return "\(arabicNum) +"
//    }
    func addShadow(circle : UIButton){
    circle.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    circle.layer.shadowOffset = CGSize(width: 1, height: 2)
    circle.layer.shadowOpacity = 2
    circle.layer.shadowRadius = 0.0
    circle.layer.masksToBounds = false
    circle.layer.cornerRadius = 0.5 * circle.bounds.size.width
    }
//    @IBAction func onClickRedo(_ sender: Any) {
//        print("### in redo btn ")
//        parentView.removeFromSuperview()
//
//        delegate?.didRedoButtonTapped()
//    }
    @IBAction func onClickOk(_ sender: Any) {
        print("### in exit btn ")
        parentView.removeFromSuperview()
        
        // Diffrent handlers based on alertType (letter? or word?)
        //        switch currentAlertType {
        //
        //        case .word:
        //            print("### in exit btn > closed as WORD ")
        //delegate?.didExitButtonTapped()
        
        
        //        case .letter:
        //            print("### in exit btn > closed as LETTER ")
        //            delegate?.didExitButtonTapped()
        
        //        case .none:
        //            //this case should never be excuted !
        //            print("### in exit btn > closed as NONE ")
        
        //        } // end switch
        
    }
}
