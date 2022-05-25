//
//  LearningPageViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 14/03/2022.
//

import UIKit
import SwiftUI


class PracticePageViewController: UIViewController {

    var allLetters = [Letters]()
    var allWords = [Words]()

    var completedLetters: [String]?
    var completedWords: [String]?
    
    @IBOutlet weak var letterButton: UIButton!
    
    @IBOutlet weak var wordButton: UIButton!
    
    @IBOutlet weak var letterLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        //will update the number only, not the percentage
        getChildData()
        designButtons()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designButtons()

    }
    
    @IBSegueAction func GoToCircleBar(_ coder: NSCoder) -> UIViewController? {
        getLettersData()
        getChildData()
        let letterPercent = Float(completedLetters!.count)/Float(allLetters.count)
        
        return UIHostingController(coder: coder, rootView: CircularProgressView(passedVal: letterPercent).background(Color(red: 205 / 255, green: 202 / 255, blue: 216 / 255)))
    }
    
    @IBSegueAction func GoToCircularBar2(_ coder: NSCoder) -> UIViewController? {
        getWordsData()
        let wordPercent = Float(completedWords!.count)/Float(allWords.count)
        return UIHostingController(coder: coder, rootView: CircularProgressView(passedVal: wordPercent).background(Color(red: 237 / 255, green: 213 / 255, blue: 141 / 255)))
    }
    
    func designButtons(){
        letterLabel.text = "\(completedLetters?.count ?? 0) من الحروف تم دراستها".convertedDigitsToLocale(Locale(identifier: "AR"))
       
        wordLabel.text = "\(completedWords?.count ?? 0) من الكلمات تم دراستها".convertedDigitsToLocale(Locale(identifier: "AR"))
        
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

    func getLettersData(){
        let lett = LocalStorage.allLettersInfo
        if lett != nil{
            allLetters = lett!
        }
    }
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }
        
    }

    func setChildInfo(child: Child){
        self.completedLetters = child.completedLetters
        self.completedWords = child.completedWords
    }
    
    func getWordsData(){
        let word = LocalStorage.allWordsInfo
        if word != nil{
            allWords = word!
        }
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
