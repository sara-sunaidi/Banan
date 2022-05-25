//
//  LearningPageVisitorViewController.swift
//  Banan
//
//  Created by Shaden Al on 01/10/1443 AH.
import UIKit

class LearningPageVisitorViewController: UIViewController {

    var allLetters = [Letters]()
    var allWords = [Words]()

    var completedLetters: [String]?
    var completedWords: [String]?
//    var player: AVAudioPlayer?
   
    
    @IBOutlet weak var letterButton: UIButton!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var wordButton: UIButton!
    

    override func viewDidAppear(_ animated: Bool) {
        //will update the number only, not the percentage
//        viewDidLoad()
        var canOpenCamera = takePhotoVC.checkCameraPermissions()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        letterButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        letterButton.layer.shadowOffset = CGSize(width: 0.0,height: 3.0)
        letterButton.layer.shadowOpacity = 0.8
        letterButton.layer.shadowRadius = 0.0
        letterButton.layer.masksToBounds = false
        
        
        wordButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        wordButton.layer.shadowOffset = CGSize(width: 0.0,height: 3.0)
        wordButton.layer.shadowOpacity = 0.8
        wordButton.layer.shadowRadius = 0.0
        wordButton.layer.masksToBounds = false
    }
    
    @IBAction func pressBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressLearnLetters(_ sender: UIButton) {
        playSound("Letters")
        
        self.performSegue(withIdentifier: "GoToLearnLettersPage", sender: self)
    }
    
    @IBAction func pressLearnWords(_ sender: UIButton) {
        playSound("Words")
        
        self.performSegue(withIdentifier: "GoToLearnWordsPage", sender: self)
    }
    
    func playSound(_ name: String){
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: name)
    }
    
}
