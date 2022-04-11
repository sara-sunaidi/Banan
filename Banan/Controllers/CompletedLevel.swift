//
//  CompletedLevel.swift
//  Banan
//
//  Created by Reema khalaf on 09/09/1443 AH.
//

import Foundation
import UIKit
import SwiftUI

// Protocol in UIView Class for navigation purposes
protocol CompletedLevelDelegate {
    func didExitButtonTapped()
    func didPlayAgainButtonTapped()
}

class CompletedLevel: UIView {
    static let instance = CompletedLevel()
    var delegate: CompletedLevelDelegate?

    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var playAgain: CustomButton!
    @IBOutlet weak var exit: CustomButton!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var animalOne: UILabel!
    @IBOutlet weak var animalTwo: UILabel!
    @IBOutlet weak var animalThree: UILabel!
    
    @IBOutlet weak var points1: UILabel!
    @IBOutlet weak var points2: UILabel!
    @IBOutlet weak var points3: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("CompletedGameLevel", owner: self, options: nil)
        
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CompletedGameLevel", owner: self, options: nil)
        
        // img format
        img.layer.cornerRadius = img.bounds.size.width/2
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.borderWidth = 5
        
        // alert dialog format
        childView.layer.cornerRadius = 50
        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    func showAlert(title: String, level: String, gameArray: [Game]) {
        commonInit()
        
        self.label?.text = title
        self.levelLabel?.text = level
        
            img?.image = UIImage(named: "shinyStar")
        
        animalOne.text = gameArray[0].Arabic
        points1.text = returnArabicNum(num: gameArray[0].currentPoint)
        
        animalTwo.text = gameArray[1].Arabic
        points2.text = returnArabicNum(num: gameArray[1].currentPoint)
        
        animalThree.text = gameArray[2].Arabic
        points3.text = returnArabicNum(num: gameArray[2].currentPoint)
        
        score.text = returnArabicNum(num: gameArray.map({$0.currentPoint}).reduce(0, +))
        
        
        UIApplication.shared.keyWindow?.addSubview(parentView!)
    }

    func returnArabicNum( num: Int) -> String{
        let arabicNum = "\(num)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        return "\(arabicNum) +"
    }
    
    @IBAction func playAgainPressed(_ sender: UIButton) {
        parentView.removeFromSuperview()
        
        delegate?.didPlayAgainButtonTapped()
    }
    
    @IBAction func exitPressed(_ sender: UIButton) {
        parentView.removeFromSuperview()
        
        delegate?.didExitButtonTapped()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
