//
//  ReflectorViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 29/04/2022.
//


import Foundation
import UIKit
import SwiftUI

// Protocol in UIView Class for navigation purposes
protocol ReflectorViewControllerDelegate {
//    func didContinueButtonTapped()
    func didExitButtonTapped()
}

class ReflectorViewController : UIView {
    
    static let instance = ReflectorViewController()
    
    @IBOutlet weak var reflector: UIImageView!
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    var name = ""
//    @IBOutlet weak var img: UIImageView!
//    @IBOutlet weak var title: UILabel!
//    @IBOutlet weak var message: UILabel!
    
    var delegate: ReflectorViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("ReflectorView", owner: self, options: nil)
        commonInit(name: name)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(name: String) {
        
        Bundle.main.loadNibNamed("ReflectorView", owner: self, options: nil)
        
        // img format
//        img.layer.cornerRadius = img.bounds.size.width/2
//        img.layer.borderColor = UIColor.white.cgColor
//        img.layer.borderWidth = 5
        
        // alert dialog format
//        let reflectorGif = UIImage.gifImageWithName("reflector")
//        let imageView = UIImageView(image: reflectorGif)
//        let Gif = UIImage.gif(name: "reflector")
//
//        // A UIImageView with async loading
//        let imageView = UIImageView()
//        imageView.loadGif(name: "tom")]
//            view.addSubview(imageView)
//        reflector.image = imageView
//        guard let confettiImageView = UIImageView.fromGif(frame: reflector.frame, resourceName: "reflector") else { return }
//        reflector.addSubview(confettiImageView)
//        confettiImageView.startAnimating()
////        confettiImageView.animationDuration = 5
//        confettiImageView.animationDuration = 3
        
        let gif = UIImage.gifImageWithName(name)
        reflector.image = gif
        alertView.layer.cornerRadius = 50

        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert() {
        print("### in showAlert confirmation")
        name = "reflector"
        commonInit(name: name)
        
//        self.title?.text = title
//        self.message?.text = message
//        if we needed to change img :
//            img?.image = UIImage(named: "ExclamationMark")
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }
    
//    @IBAction func onClickYes(_ sender: Any) {
//        print("### in Yes btn ")
//        parentView.removeFromSuperview()
//
//        delegate?.didContinueButtonTapped()
//
//    }
//
    
    @IBAction func onClickCancel(_ sender: Any) {
        print("### in Cancel btn ")
        parentView.removeFromSuperview()
        delegate?.didExitButtonTapped()
    }
    
    
}

