//
//  GameLevelsViewController.swift
//  Banan
//
//  Created by Reema khalaf on 03/09/1443 AH.
//

import UIKit

class GameLevelsViewController: UIViewController, CompletedLevelDelegate {
    func didExitButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didPlayAgainButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
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
    
    
    var gameLevels = [[String: String]]()
    var allAnimals = [Game]()
    var Level1 = [Game]()
    var Level2 = [Game]()
    var Level3 = [Game]()

    var num : Int = 0
    var LevelNumber : Int = 0
    var LevelOne : Bool = false
    var LevelTwo : Bool = false
    var LevelThree : Bool = false

    override func viewDidAppear(_ animated: Bool) {
        getChildData()
        getGameAnimalsData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getChildData()
        getGameAnimalsData()
        groupByLevel()
        
        num = gameLevels.count-1
        
        for i in 0...num {
        let points = gameLevels.map{$0["UserPoints"]!}
            if (Double(points[i]) ?? 0 >= 0.20) {
               let levels = gameLevels.map{$0["Level"]!}
                  switch levels[i] {
                   case "First": LevelOne = true
                   case "Second": LevelTwo = true
                   case "Third": LevelThree = true
                  default:
                    LevelOne = false
                    LevelTwo = false
                    LevelThree = false
                }
            }
        }


        designButton(button: level1, pic: pic1, lock: lock1, completed: LevelOne, comp: LevelOne, label: label1)
        designButton(button: level2, pic: pic2, lock: lock2, completed: LevelTwo, comp: LevelOne, label: label2)
        designButton(button: level3, pic: pic3, lock: lock3, completed: LevelThree, comp: LevelTwo, label: label3)

        CompletedLevel.instance.delegate = self
    }
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }}
    
    func getGameAnimalsData(){
        let animal = LocalStorage.allGameInfo
        if animal != nil{
            allAnimals = animal!
        }
    }
    
    func setChildInfo(child: Child){
        self.gameLevels = child.GameLevels
    }
    
    func designButton(button : UIButton ,pic : UIImageView ,lock : UIImageView ,completed : Bool ,comp : Bool , label : UILabel){
        if (comp) {
        button.tintColor =  UIColor(red: 220/255, green: 156/255, blue: 123/255, alpha: 1)
        let yourImage: UIImage = UIImage(named: "Vector (5)")!
        pic.image = yourImage
        let image : UIImage = UIImage(named:"openlock")!
        lock.image = image
        label.textColor = UIColor(red: 169/255, green: 106/255, blue: 74/255, alpha: 1)
        }
        if (completed) {
//        button.tintColor =  UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
            button.tintColor =  UIColor(red: 220/255, green: 156/255, blue: 123/255, alpha: 1)
            let yourImage: UIImage = UIImage(systemName: "checkmark.circle.fill")!
        lock.image = yourImage
        lock.tintColor = UIColor(red: 169/255, green: 106/255, blue: 74/255, alpha: 1)
      
        }
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
    func groupByLevel() {

        Level1 = allAnimals.filter({$0.Level == "First"})
        Level2 = allAnimals.filter({$0.Level == "Second"})
        Level3 = allAnimals.filter({$0.Level == "Third"})
        
        }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func levelOnePressed(_ sender: UIButton) {
        LevelNumber = 1
        
        if (LevelOne) {
            CompletedLevel.instance.showAlert(title: "أحسنت", level: "أكملت المستوى الأول", gameArray: Level1)
        } else {
            
        }
            
    }
    @IBAction func levelTwoPressed(_ sender: UIButton) {
        LevelNumber = 2
        
        if (LevelTwo) {
            CompletedLevel.instance.showAlert(title: "أحسنت", level: "أكملت المستوى الثاني", gameArray: Level2)
        } else {
            
        }

    }
    @IBAction func levelThreePressed(_ sender: UIButton) {
        LevelNumber = 3
        
        if (LevelThree) {
            CompletedLevel.instance.showAlert(title: "أحسنت", level: "أكملت المستوى الثالث", gameArray: Level3)
        } else {
            
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
