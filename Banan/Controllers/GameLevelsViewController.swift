//
//  GameLevelsViewController.swift
//  Banan
//
//  Created by Reema khalaf on 03/09/1443 AH.
//

import UIKit

class GameLevelsViewController: UIViewController {

    //buttons
    @IBOutlet weak var level1: UIButton!
    @IBOutlet weak var level2: UIButton!
    @IBOutlet weak var level3: UIButton!
    //images
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    //lock
    @IBOutlet weak var lock1: UIImageView!
    @IBOutlet weak var lock2: UIImageView!
    @IBOutlet weak var lock3: UIImageView!
    //labels
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score3: UILabel!
    
    var gameLevels = [[String: String]]()

    var num : Int = 0
    var currentLevel : [Game] = []

    var LevelNumber : String = ""
    var LevelOne : Bool = false
    var LevelTwo : Bool = false
    var LevelThree : Bool = false
    
    var Level1 : Double = 0
    var Level2 : Double = 0
    var Level3 : Double = 0

    var val : Int = 0

    override func viewDidAppear(_ animated: Bool) {
        getChildData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level1.tintColor =  UIColor(red: 220/255, green: 156/255, blue: 123/255, alpha: 1)
       level2.tintColor =  UIColor(hue: 0.4167, saturation: 0.21, brightness: 0.61, alpha: 1.0) /* #7c9d8d */
        level3.tintColor =  UIColor(hue: 0.4167, saturation: 0.21, brightness: 0.61, alpha: 1.0) /* #7c9d8d */

        
        getChildData()
        
        score1.text = ""
        score2.text = ""
        score3.text = ""

        num = gameLevels.count-1
        
        for i in 0...num {
        let points = gameLevels.map{$0["Score"]!}
            if (Double(points[i]) ?? 0 >= 0.20) {
               let levels = gameLevels.map{$0["Level"]!}
                  switch levels[i] {
                   case "First": LevelOne = true
                      Level1 = Double(points[i]) ?? 0
                   case "Second": LevelTwo = true
                      Level2 = Double(points[i]) ?? 0
                   case "Third": LevelThree = true
                      Level3 = Double(points[i]) ?? 0
                  default:
                    LevelOne = false
                    LevelTwo = false
                    LevelThree = false
                }
            }
        }
//        print("ggggggg")
//        print(LevelOne)
//        print(Level1)
//        print(LevelTwo)
//        print(Level2)
//        print(LevelThree)
//        print(Level3)
//        print("ggggggg")

        designButton(button: level1)
        designButton(button: level2)
        designButton(button: level3)
        
        if(LevelOne) {
            designCurrentLevel(button: level1, pic: pic1, lock: lock1, label: score1, score: Level1)
            designNextLevel(button: level2, pic: pic2, lock: lock2, label: label2)
        }
        if(LevelTwo) {
            designCurrentLevel(button: level2, pic: pic2, lock: lock2, label: score2, score: Level2)
            designNextLevel(button: level3, pic: pic3, lock: lock3, label: label3)
        }
        if(LevelThree){
            designCurrentLevel(button: level3, pic: pic3, lock: lock3, label: score3, score: Level3)
        }
    }
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }}
    
    func setChildInfo(child: Child){
        self.gameLevels = child.GameLevels
    }
    
    func designButton(button : UIButton){
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
    func designNextLevel (button : UIButton ,pic : UIImageView ,lock : UIImageView, label : UILabel) {
        
        button.tintColor =  UIColor(red: 220/255, green: 156/255, blue: 123/255, alpha: 1)
        let yourImage: UIImage = UIImage(named: "Vector (5)")!
        pic.image = yourImage
        let image : UIImage = UIImage(named:"openLock")!
        lock.image = image
        label.textColor = UIColor(red: 169/255, green: 106/255, blue: 74/255, alpha: 1)
    }
    
    func designCurrentLevel(button : UIButton ,pic : UIImageView ,lock : UIImageView, label : UILabel, score : Double) {
        button.tintColor =  UIColor(red: 220/255, green: 156/255, blue: 123/255, alpha: 1)
        let yourImage: UIImage = UIImage(named: "star")!
    lock.image = yourImage

        label.text = "\(returnArabicNum(num: Int(score*100)))/١٠٠"
    }
    
    func returnArabicNum( num: Int) -> String{
        let arabicNum = "\(num)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        return "\(arabicNum)"
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func levelOnePressed(_ sender: UIButton) {
        LevelNumber = "First"
        let game = LocalStorage.allGameInfo
            currentLevel = game!.filter({$0.Level == "First"})
        performSegue(withIdentifier: "GoToGame", sender: self)
    }
    @IBAction func levelTwoPressed(_ sender: UIButton) {
        LevelNumber = "Second"
        let game = LocalStorage.allGameInfo
            currentLevel = game!.filter({$0.Level == "Second"})
        if(LevelOne) {
            performSegue(withIdentifier: "GoToGame", sender: self)

        }
    }
    @IBAction func levelThreePressed(_ sender: UIButton) {
        LevelNumber = "Third"
        let game = LocalStorage.allGameInfo
            currentLevel = game!.filter({$0.Level == "Third"})
        if(LevelTwo) {
            performSegue(withIdentifier: "GoToGame", sender: self)

        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToGame" {
            let destinationVC = segue.destination as? GameViewController
            destinationVC?.levelNum = LevelNumber
            destinationVC?.currentLevel = currentLevel

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

}
