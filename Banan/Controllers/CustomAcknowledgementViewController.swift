//
//  CustomAcknowledgementViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
//
import Foundation
import UIKit
import SwiftUI
protocol CustomAcknowledgementViewControllerDelegate {
    func didDoneButtonTapped()
}
class CustomAcknowledgementViewController: UIView {

    static let instance = CustomAcknowledgementViewController()
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var message: UILabel!
    var delegate : CustomAcknowledgementViewControllerDelegate?
    // enum to perform diffrent format for each AcknowledgementType.
    enum AcknowledgementType {
        case positive
        case negative
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("CustomAcknowledgementView", owner: self, options: nil)
        
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CustomAcknowledgementView", owner: self, options: nil)
        
        // img format
        img.layer.cornerRadius = img.bounds.size.width/2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 5
        
        // alert dialog format
        alertView.layer.cornerRadius = 50
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert(title: String, message: String, acknowledgementType: AcknowledgementType) {
        
        commonInit()
        
        self.title?.text = title
        self.message?.text = message
        
        switch acknowledgementType {
            
        case .positive:
            img?.image = UIImage(named: "CheckSign")
            
        case .negative:
            img?.image = UIImage(named: "ExclamationMark")
        } // end switch
        
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
    @IBAction func onClickDone(_ sender: Any) {
            parentView.removeFromSuperview()
        delegate?.didDoneButtonTapped()
    }
   
    
}
