//
//  InstructiosViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 06/05/2022.
//

import Foundation

protocol InstructionsViewControllerDelegate {
    func didDoneButtonTapped()
}
class InstructionsViewController : UIView {
    static let instance = InstructionsViewController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var parentView: UIView!
    var name = ""
    @IBOutlet weak var doneButton: UIButton!
    var delegate : InstructionsViewControllerDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("InstructionsView", owner: self, options: nil)
        
        commonInit(name: name)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit(name: String) {
        
       Bundle.main.loadNibNamed("InstructionsView", owner: self, options: nil)
       let instructionGif = UIImage.gifImageWithName(name)
        imageView.image = instructionGif
        alertView.layer.cornerRadius = 50
        videoView.layer.cornerRadius = 50
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert(name: String) {
        
        commonInit(name: name)
        
        customButton(doneButton)
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
    @IBAction func OnClickDone(_ sender: Any) {
        parentView.removeFromSuperview()
        delegate?.didDoneButtonTapped()
    }
    func customButton(_ sender: UIButton){
        sender.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        sender.layer.shadowOpacity = 0.8
        sender.layer.shadowRadius = 3.0
        sender.layer.masksToBounds = false
    }
}

