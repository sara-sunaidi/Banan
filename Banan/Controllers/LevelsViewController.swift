//
//  LetterLevelsViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 07/03/2022.
//

import UIKit

class LevelsViewController: UIViewController {
    
    var allLetters = [Letters]()
    
    //levels
    var first = [Letters]()
    var second = [Letters]()
    var third = [Letters]()
    var fourth = [Letters]()
    var fifth = [Letters]()
    var sixth = [Letters]()
    var seventh = [Letters]()
    var eighth = [Letters]()
    var ninth = [Letters]()
    var tenth = [Letters]()
    
    
    var chosenLevel = [Letters]()
    var levelTitle : String?
    
    var completedLevels = [String]()
    var completedLetters = [String]()

    //buttons
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    @IBOutlet weak var seventhButton: UIButton!
    @IBOutlet weak var eighthButton: UIButton!
    @IBOutlet weak var ninthButton: UIButton!
    @IBOutlet weak var tenthButton: UIButton!
    
    
    //labels
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLable: UILabel!
    @IBOutlet weak var sixthLable: UILabel!
    @IBOutlet weak var seventhLable: UILabel!
    @IBOutlet weak var eighthLable: UILabel!
    @IBOutlet weak var ninthLable: UILabel!
    @IBOutlet weak var tenthLable: UILabel!
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidAppear(_ animated: Bool) {        
        if(appdelegate.isChild){
            getChildData()
        }
        getLettersData()
        groupByLevel()
        buttonLevels()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(appdelegate.isChild){
            getChildData()}
        getLettersData()
        groupByLevel()
        buttonLevels()
        
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
        self.completedLevels = child.completedLevels
    }
    
    func buttonLevels(){
        
        designButton(completed: completedLevels.contains("First"), levelArray: first, label: firstLabel, button: firstButton)
        
        designButton(completed: completedLevels.contains("Second"), levelArray: second, label: secondLabel, button: secondButton)
        
        designButton(completed: completedLevels.contains("Third"), levelArray: third, label: thirdLabel, button: thirdButton)
        
        designButton(completed: completedLevels.contains("Fourth"), levelArray: fourth, label: fourthLabel, button: fourthButton)
        
        designButton(completed: completedLevels.contains("Fifth"), levelArray: fifth, label: fifthLable
                     , button: fifthButton)
        
        designButton(completed: completedLevels.contains("Sixth"), levelArray: sixth, label: sixthLable, button: sixthButton)
        
        designButton(completed: completedLevels.contains("Seventh"), levelArray: seventh, label: seventhLable, button: seventhButton)
        
        designButton(completed: completedLevels.contains("Eighth"), levelArray: eighth, label: eighthLable, button: eighthButton)
        
        designButton(completed: completedLevels.contains("Ninth"), levelArray: ninth, label: ninthLable, button: ninthButton)
        
        designButton(completed: completedLevels.contains("Tenth"), levelArray: tenth, label: tenthLable, button: tenthButton)
    }
    
    
    func designButton(completed: Bool, levelArray: [Letters], label: UILabel, button: UIButton){
        
        let filteredArray = levelArray.map{$0.Letter}
        let intersect = Set(filteredArray).intersection(completedLetters).count
        
        //English num to Arabic num
        let arabicIntersect = "\(intersect)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let arabicTotal = "\(levelArray.count)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        if(completed){
            //green color
            button.backgroundColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }

        if (appdelegate.isChild){
            label.text = "\(arabicTotal)/\(arabicIntersect) من الحروف تم دراستها"
        }
        
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
    }
    
    
    func groupByLevel() {
        first = allLetters.filter({$0.Level == "First"})
        second = allLetters.filter({$0.Level  == "Second"})
        third = allLetters.filter({$0.Level == "Third"})
        fourth = allLetters.filter({$0.Level == "Fourth"})
        fifth = allLetters.filter({$0.Level == "Fifth"})
        sixth = allLetters.filter({$0.Level == "Sixth"})
        seventh = allLetters.filter({$0.Level == "Seventh"})
        eighth = allLetters.filter({$0.Level == "Eighth"})
        ninth = allLetters.filter({$0.Level == "Ninth"})
        tenth = allLetters.filter({$0.Level == "Tenth"})
    }
    
    
    @IBAction func pressBack(_ sender: UIButton) {
        PlayAllSounds.sharedInstance.stop()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func levelPressed(_ sender: UIButton) {
        switch sender{
        case firstButton:
            playSound("First")
            chosenLevel = first
            levelTitle = "المستوى الأول"
            break;
            
        case secondButton:
            playSound("Second")
            chosenLevel = second
            levelTitle = "المستوى الثاني"
            break;
            
        case thirdButton:
            playSound("Third")
            chosenLevel = third
            levelTitle = "المستوى الثالث"
            break;
            
        case fourthButton:
            playSound("Fourth")
            chosenLevel = fourth
            levelTitle = "المستوى الرابع"
            break;
            
        case fifthButton:
            playSound("Fifth")
            chosenLevel = fifth
            levelTitle = "المستوى الخامس"
            break;
            
        case sixthButton:
            playSound("Sixth")
            chosenLevel = sixth
            levelTitle = "المستوى السادس"
            break;
            
        case seventhButton:
            playSound("Seventh")
            chosenLevel = seventh
            levelTitle = "المستوى السابع"
            break;
            
        case eighthButton:
            playSound("Eighth")
            chosenLevel = eighth
            levelTitle = "المستوى الثامن"
            break;
            
        case ninthButton:
            playSound("Ninth")
            chosenLevel = ninth
            levelTitle = "المستوى التاسع"
            break;
            
        case tenthButton:
            playSound("Tenth")
            chosenLevel = tenth
            levelTitle = "المستوى العاشر"
            break;
            
        default:
            print("select another btn level")
        }
        
        if(chosenLevel.count == 2){
            self.performSegue(withIdentifier: "GoToLetters2", sender: self)
        }
        else if( chosenLevel.count == 3){
            self.performSegue(withIdentifier: "GoToLetters3", sender: self)
        }
        else if(chosenLevel.count == 4){
            self.performSegue(withIdentifier: "GoToLetters4", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // do the same for all three views
        
        if segue.identifier == "GoToLetters2"{
            let destination = segue.destination as! Letters2ViewController
            destination.letters = chosenLevel
            destination.levelTitle = levelTitle
        }
        
        else if segue.identifier == "GoToLetters3"{
            let destination = segue.destination as! Letters3ViewController
            destination.letters = chosenLevel
            destination.levelTitle = levelTitle
        }
        
        else if segue.identifier == "GoToLetters4"{
            let destination = segue.destination as! Letters4ViewController
            destination.letters = chosenLevel
            destination.levelTitle = levelTitle
        }
    }
    
    // play sound
    func playSound(_ name:String) {
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: name)
    }
}
