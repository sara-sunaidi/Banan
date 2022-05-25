//
//  GameInstructionsViewController.swift
//  Banan
//
//  Created by Shaden Al on 26/09/1443 AH.
//

import Foundation
protocol GameInstructionsViewControllerDelegate {
    func didDoneButtonTapped()
    func didNextPopUpButtonTapped()
}
class GameInstructionsViewController : UIView
{
    func didDoneButtonTapped() {
        
    }
    func didNextPopUpButtonTapped() {
        
    }
    
    static let instance = GameInstructionsViewController()
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imaageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var parentView: UIView!
    
    var delegate : GameInstructionsViewControllerDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("GameInstructionsView", owner: self, options: nil)
        
        commonInit()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
       
       Bundle.main.loadNibNamed("GameInstructionsView", owner: self, options: nil)
       let gameGif = UIImage.gifImageWithName("GameInstructions")
        imaageView.image = gameGif
        alertView.layer.cornerRadius = 50
        videoView.layer.cornerRadius = 50
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAlert() {
        
        commonInit()
        customButton(nextButton)
        customButton(doneButton)
        
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }

    @IBAction func OnClickNext(_ sender: UIButton) {
        parentView.removeFromSuperview()
            delegate?.didNextPopUpButtonTapped()

    }


    @IBAction func OnClickDone(_ sender: UIButton) {
        parentView.removeFromSuperview()
        delegate?.didDoneButtonTapped()
    }
    @IBAction func OnCkickYes(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    func customButton(_ sender: UIButton){
        sender.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        sender.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        sender.layer.shadowOpacity = 0.8
        sender.layer.shadowRadius = 3.0
        sender.layer.masksToBounds = false
    }

}
