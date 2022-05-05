//
//  LearningPageVisitorViewController.swift
//  Banan
//
//  Created by Shaden Al on 01/10/1443 AH.
import UIKit
import SwiftUI
import FirebaseFirestore
import Firebase

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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    


   
    
    


    
    @IBAction func pressBack(_ sender: UIButton) {
//        player?.stop()

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressLearnLetters(_ sender: UIButton) {
//        playSound("Letters")
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: "Letters")
        self.performSegue(withIdentifier: "GoToLearnLettersPage", sender: self)
    }
    
    @IBAction func pressLearnWords(_ sender: UIButton) {
//        playSound("Words")
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: "Words")
        self.performSegue(withIdentifier: "GoToLearnWordsPage", sender: self)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


