//
//  StopGameViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 03/04/2022.
//
import Foundation
import UIKit

// Protocol in UIView Class for navigation purposes
protocol StopGameViewControllerDelegate {
    func didContinueButtonTapped()
    func didExitButtonTapped()
}

class StopGameViewController : UIView {
    
    static let instance = StopGameViewController()
    
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    var delegate: StopGameViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("StopGameView", owner: self, options: nil)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("StopGameView", owner: self, options: nil)
        
        // alert dialog format
        alertView.layer.cornerRadius = 50
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert() {
        commonInit()
        
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
    @IBAction func onClickYes(_ sender: Any) {
        parentView.removeFromSuperview()
        
        delegate?.didContinueButtonTapped()
        
    }
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        parentView.removeFromSuperview()
        delegate?.didExitButtonTapped()
    }
    
}
