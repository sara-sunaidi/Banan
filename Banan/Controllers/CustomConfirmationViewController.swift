//
//  CustomConfirmationViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
//

import Foundation
import UIKit
import SwiftUI

// Protocol in UIView Class for navigation purposes
protocol CustomConfirmationViewControllerDelegate {
    func didYesButtonTapped()
    func didCancelButtonTapped()
}

class CustomConfirmationViewController : UIView {
    
    static let instance = CustomConfirmationViewController()
    
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    
    var delegate: CustomConfirmationViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomConfirmationView", owner: self, options: nil)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CustomConfirmationView", owner: self, options: nil)
        
        // img format
        img.layer.cornerRadius = img.bounds.size.width/2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 5
        
        // alert dialog format
        alertView.layer.cornerRadius = 50
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert(title: String, message: String) {
        print("### in showAlert confirmation")
        commonInit()
        
        self.title?.text = title
        self.message?.text = message
//        if we needed to change img :
            img?.image = UIImage(named: "ExclamationMark")

        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
    @IBAction func onClickYes(_ sender: Any) {
        print("### in Yes btn ")
        parentView.removeFromSuperview()
        
        delegate?.didYesButtonTapped()
        
    }
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        print("### in Cancel btn ")
        parentView.removeFromSuperview()
        
        delegate?.didCancelButtonTapped()
    }
    
    
}
