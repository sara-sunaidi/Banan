//
//  LearnLetterViewController.swift
//  Banan
//
//  Created by Noura  on 10/08/1443 AH.
//

//import Foundation
import UIKit
import SwiftUI
import AVFoundation

class LearnLetterViewController: UIViewController {
    
    @IBOutlet weak var imageLetter: UIImageView!
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var circle1: UIButton!
    @IBOutlet weak var circle2: UIButton!
    @IBOutlet weak var circle3: UIButton!
    @IBOutlet weak var circle4: UIButton!
    @IBOutlet weak var circle5: UIButton!
    @IBOutlet weak var circle6: UIButton!
    @IBOutlet weak var soundBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    
    @IBOutlet weak var prevLetterButton: UIButton!
    
    var letters : [Letters]?
    var index: Int?
    var strLetter: String = "حرف "
    //= "حرف اللام"
    var player: AVAudioPlayer?
    //    private let progressView: UIProgressView = {
    //        let progressView = UIProgressView(progressViewStyle: .bar)
    //        progressView.trackTintColor = .gray
    //        progressView.progressTintColor = UIColor(named: "Color")
    //        progressView.transform = progressView.transform.scaledBy(x: 1, y: 20)
    //
    //        return progressView
    //    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let lettersWithout = ["2aa", "Alf", "2lf", "Ttt"]
        //2aa = ء
        //Alf = ا
        //2lf = أ
        //Ttt = ة
        if(index! == 0){
            // or change background to gray?
            prevLetterButton.isHidden = true
            //need to change plain to default
            //            prevLetterButton.backgroundColor = UIColor(red: 134/255, green: 128/255, blue: 124/255, alpha: 0.5)
        }
        if(lettersWithout.contains(letters![index!].Letter)){
            strLetter = ""
        }
        //playSound()
        // progressView1.frame = CGRect(x: 50, y: 20, width: 1000, height: 100)
        strLetter += letters![index!].Arabic
        
        letter.text = strLetter
        let image = UIImage(named: "\(letters![index!].imageName)")
        imageLetter.image = image
        
        progressView1.layer.borderWidth = 5;
        progressView1.layer.borderColor =  UIColor(red:255/255, green:255/255, blue:255/255, alpha:1).cgColor
        // Set the rounded edge for the outer bar
        progressView1.layer.cornerRadius = 15
        progressView1.clipsToBounds = true
        
        // Set the rounded edge for the inner bar
        progressView1.layer.sublayers![1].cornerRadius = 15
        progressView1.subviews[1].clipsToBounds = true
        
        progressView1.transform = CGAffineTransform(rotationAngle: .pi);
        progressView1.setProgress(0, animated: true)
        
        addShadow(circle1)
        addShadow(circle2)
        addShadow(circle3)
        addShadow(circle4)
        addShadow(circle5)
        addShadow(circle6)
        addShadowBtn(soundBtn)
        addShadowBtn(helpBtn)
        addShadowBtn(exitBtn)
        
        addColor(letters![index!].Braille)
    }
    
    @IBAction func pressSound(_ sender: UIButton) {
        playSound()
    }
    // add shadow to circle
    func addShadow(_ crl: UIButton){
        crl.backgroundColor = UIColor(red:204/255, green:204/255, blue:204/255, alpha:1)
        crl.layer.borderWidth = 0
        
        crl.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        crl.layer.shadowOffset = CGSize(width: 1, height: 2)
        crl.layer.shadowOpacity = 2
        crl.layer.shadowRadius = 0.0
        crl.layer.masksToBounds = false
        //crl.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        crl.layer.cornerRadius = 0.5 * crl.bounds.size.width
        
        
        
    }
    // add shadow to btns
    func addShadowBtn(_ btn: UIButton){
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 1, height: 3)
        btn.layer.shadowOpacity = 0.8
        btn.layer.shadowRadius = 0.0
        btn.layer.masksToBounds = false
    }
    // add color to circle
    func addColor(_ st: String){
        for (i,s) in st.enumerated() {
            
            if(s=="1"){
                if(i==0){
                    circle1.backgroundColor = UIColor(named: "Color1")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle1.layer.borderWidth = 4
                    circle1.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor}
                else if(i==1){
                    circle2.backgroundColor = UIColor(named: "Color1")
                    //UIColor(red:118/255, green:168/255, blue:158/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle2.layer.borderWidth = 4
                    circle2.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor}
                else if(i==2){
                    circle3.backgroundColor = UIColor(named: "Color1")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle3.layer.borderWidth = 4
                    circle3.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor}
                else if(i==3){
                    circle4.backgroundColor = UIColor(named: "Color1")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle4.layer.borderWidth = 4
                    circle4.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor}
                else if(i==4){
                    circle5.backgroundColor = UIColor(named: "Color1")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle5.layer.borderWidth = 4
                    circle5.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor}
                else{
                    circle6.backgroundColor = UIColor(named: "Color1")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle6.layer.borderWidth = 4
                    circle6.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor}
            }
        }
    }
    
    // play sound
    func playSound() {
        //progressView1.setProgress(0.3, animated: true)
        
        guard let url = Bundle.main.url(forResource: "Thl", withExtension: "mp3") else { return }
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
    // set progress bar
    func setProgress(){
        
    }
    
    // animate progress bar
    func animateProgress(){
        
    }
    @IBAction func pressBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressPreviousLetter(_ sender: UIButton) {
        index = index! - 1
        strLetter = "حرف "
        
        viewDidLoad()
    }
      
    
}