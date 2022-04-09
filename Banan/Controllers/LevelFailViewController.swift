//
//  LevelFailViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 04/04/2022.
//
import Foundation
import UIKit
import SwiftUI
import AVFoundation

// Protocol in UIView Class for navigation purposes
protocol LevelFailViewControllerDelegate {
    func didExitButtonTapped()
    func didRedoButtonTapped()
}

class LevelFailViewController : UIView {
    
    static let instance = LevelFailViewController()
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var redoBtn: CustomButton!
    

    @IBOutlet weak var exitBtn: CustomButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var level: UILabel!
    
    @IBOutlet weak var word1: UILabel!
    @IBOutlet weak var score1: UILabel!
    
    @IBOutlet weak var word2: UILabel!
    @IBOutlet weak var score2: UILabel!
    
    @IBOutlet weak var word3: UILabel!
    @IBOutlet weak var score3: UILabel!
    
    @IBOutlet weak var levelScore: UILabel!
    
    var player: AVAudioPlayer?

    
    var delegate: LevelFailViewControllerDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("LevelFailView", owner: self, options: nil)
        
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("LevelFailView", owner: self, options: nil)
        
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
        
    }
    func playSound(soundName: String){
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        //to find sound name:
        //letters![index!].Letter
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func showAlert(title: String, level: String, gameArray: [Game], totalScore: Int, imageName: String, soundName: String) {
//        currentAlertType = alertType
        commonInit()
        playSound(soundName: soundName)
        
        self.title?.text = title
        self.level?.text = level
        

        
        word1.text = gameArray[0].Arabic
        score1.text = returnArabicNum(num: gameArray[0].currentPoint)
        
        word2.text = gameArray[1].Arabic
        score2.text = returnArabicNum(num: gameArray[1].currentPoint)
        
        word3.text = gameArray[2].Arabic
        score3.text = returnArabicNum(num: gameArray[2].currentPoint)
        
        
//        var levelTotal = gameArray.map({Int($0.Points) ?? 0}).reduce(0, +)
//        var userTotal = gameArray.map({$0.currentPoint}).reduce(0, +)
        
        levelScore.text = returnArabicNum(num: totalScore)
        
        
//        if(Float(userTotal)/Float(levelTotal) <0.2
//        img?.image = UIImage(named: "shinyStar")
        img?.image = UIImage(named: imageName)

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
    func returnArabicNum( num: Int) -> String{
        let arabicNum = "\(num)".convertedDigitsToLocale(Locale(identifier: "AR"))

        return "\(arabicNum) +"
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
