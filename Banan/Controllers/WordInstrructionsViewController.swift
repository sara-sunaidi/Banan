//
//  WordInstrructionsViewController.swift
//  Banan
//
//  Created by Shaden Al on 26/09/1443 AH.
//

import Foundation
protocol WordInstructionsViewControllerDelegate {
    func didDoneButtonTapped()
}
class WordInstructionsViewController : UIView {
    static let instance = WordInstructionsViewController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var doneButton: UIButton!
    var delegate : WordInstructionsViewControllerDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("WordInstructionsView", owner: self, options: nil)
        
        commonInit()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        
       Bundle.main.loadNibNamed("WordInstructionsView", owner: self, options: nil)
       let WordGif = UIImage.gifImageWithName("WordInstructions")
        imageView.image = WordGif
        alertView.layer.cornerRadius = 50
        videoView.layer.cornerRadius = 50
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert() {
        
        commonInit()
        
        customButton(doneButton)
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
    @IBAction func OnClickDone(_ sender: Any) {parentView.removeFromSuperview()
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