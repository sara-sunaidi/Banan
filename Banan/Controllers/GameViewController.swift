//
//  GameViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 01/04/2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, StopGameViewControllerDelegate, LevelDoneViewControllerDelegate {
    func didNextButtonTapped() {
        print("next pressed")
    }
    
    func didRedoButtonTapped() {
        print("redo pressed")
    }
    
    
    
    
    @IBOutlet weak var heart1: UIButton!
    @IBOutlet weak var heart2: UIButton!
    @IBOutlet weak var heart3: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalLabel: UILabel!
    
    
    @IBOutlet weak var stopIcon: UIButton!
    
    @IBOutlet weak var passedAnimals: UILabel!
    
    
    @IBOutlet weak var skipButton: UIButton!
    
    var player: AVAudioPlayer?

    var completedGameAnimal = [[String:String]]()
    
    var gameLevel = [
        Game(
            AllLetters:["2lf","Sen","Dal"],
            Arabic: "أسد",
            Level:"First",
            Points: "100",
            Animal: "Lion"),
        
        
        Game(
            AllLetters:["Kaf","Lam","Baa"],
            Arabic: "كلب",
            Level:"First",
            Points: "130",
            Animal: "Dog"),
        
        Game(
            AllLetters:["Gaf","Raa","Dal"],
            Arabic: "قرد",
            Level:"First",
            Points: "125",
            Animal: "Monkey")
        
        
    ]
    
    var levelPoints = 0
    var levelUserPoints = 0
    var index = 0
    var numOfHeart = 3;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player?.stop()

        if(index == gameLevel.count - 1){
            //last animal
            skipButton.isHidden = true
        }
            
        levelPoints = gameLevel.map({Int($0.Points)!}).reduce(0, +)
        levelUserPoints = gameLevel.map({$0.currentPoint}).reduce(0, +)
        
        //design progressbar
        designProgressbar()
        getChildData()
        updatePassedLabel()
        updateAnimalInfo()
        
        
        StopGameViewController.instance.delegate = self
        LevelDoneViewController.instance.delegate = self
    }
    func designProgressbar(){
        
        progressBar.layer.borderWidth = 5;
        progressBar.layer.borderColor =  UIColor(red:255/255, green:255/255, blue:255/255, alpha:1).cgColor
        // Set the rounded edge for the outer bar
        progressBar.layer.cornerRadius = 15
        progressBar.clipsToBounds = true
        
        // Set the rounded edge for the inner bar
        progressBar.layer.sublayers![1].cornerRadius = 15
        progressBar.subviews[1].clipsToBounds = true
        
        progressBar.transform = CGAffineTransform(rotationAngle: .pi);
    }
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            self.completedGameAnimal = child!.completedGameAnimal
            
        }
    }
    
    func updatePassedLabel(){
        //        completedGameAnimal.
        let filterLevel = gameLevel.map{$0.Animal}
        let filterCompleted = completedGameAnimal.map{$0["Animal"]}
        
        let intersect = Set(filterLevel).intersection(filterCompleted).count
        
        
        //English num to Arabic num
        let arabicIntersect = "\(intersect)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let arabicTotal = "\(filterLevel.count)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        passedAnimals.text = "\(arabicTotal)/\(arabicIntersect)"
        
    }
    
    func updateAnimalInfo(){
        animalImage.image = UIImage(named: "\(gameLevel[index].Animal)")
                
        animalLabel.text = gameLevel[index].Arabic
        
        //update num of hearts because its new animal
        numOfHeart = 3;
        updateHeart()
    }

    
    func updateHeart(){
        if(numOfHeart == 2){
            colorHeart(colorName: "gray", btn: heart1)
        }
        if(numOfHeart == 1){
            colorHeart(colorName: "gray", btn: heart1)
            colorHeart(colorName: "gray", btn: heart2)
        }
        
        if(numOfHeart == 0){
            colorHeart(colorName: "gray", btn: heart1)
            colorHeart(colorName: "gray", btn: heart2)
            colorHeart(colorName: "gray", btn: heart3)
        }
        
        //reset to red
        if(numOfHeart == 3){
            colorHeart(colorName: "red", btn: heart1)
            colorHeart(colorName: "red", btn: heart2)
            colorHeart(colorName: "red", btn: heart3)
        }
    }
    
    func colorHeart(colorName: String, btn: UIButton){
        
        if( colorName == "red"){
            btn.tintColor = UIColor(red:192/255, green:77/255, blue:51/255, alpha:1)
        }
        //gray
        else{
            btn.tintColor = UIColor(red:204/255, green:204/255, blue:204/255, alpha:1)
        }
    }
    
    @IBAction func pressSpeaker(_ sender: UIButton) {
        print("play sound")
        
        
        guard let url = Bundle.main.url(forResource: "\(gameLevel[index].Animal)", withExtension: "mp3") else { return }
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
    
    
    @IBAction func pressInstructions(_ sender: UIButton) {
        
        print( "press Instructions")
    }
    
    @IBAction func pressHint(_ sender: UIButton) {
        
        print("press hint")
        if(numOfHeart != 0){
            numOfHeart = numOfHeart - 1
            updateHeart()
        }
        else{
            print("no hearts left")
            numOfHeart = 3
            updateHeart()
        }
    }
    
    @IBAction func pressCheck(_ sender: UIButton) {
        
    
        print("press check")
        
        //if the answer was correct, do the following
        
        var curPoints = Int(gameLevel[index].Points) ?? 0
        print(curPoints)
        //if num of heart == 0 ? (+20)
        curPoints = Int((Float(curPoints - 20 )/3.0) * Float(numOfHeart))
        curPoints += 20
        
        gameLevel[index].currentPoint = curPoints
        print(curPoints)
        
        levelUserPoints = gameLevel.map({$0.currentPoint}).reduce(0, +)
        
        
        //update progresssbar
        progressBar.setProgress(Float(levelUserPoints)/Float(levelPoints), animated: true)
        
        
        //if level did not finish
        if(index != gameLevel.count - 1){
            index = index + 1
            
            viewDidLoad()
        }
        //else pop up message with total points and pass or fail
        //total point in level
        else{
            LevelDoneViewController.instance.showAlert(title: "sara", level: "test", gameArray: gameLevel)
//            var levelPoints = 0
//            for i in gameLevel{
//               print(i.Arabic)
//               print( i.currentPoint)
//                levelPoints += i.currentPoint
//            }
            print("level points: \(levelUserPoints)")
        }

    }
    
    @IBAction func pressSkip(_ sender: UIButton) {
        
        print("press skip")
        if(index != gameLevel.count - 1){
            index += 1
            viewDidLoad()
        }
        
    }
    
    @IBAction func pressStop(_ sender: UIButton) {
        
        player?.stop()
        
        print("press stop")
        stopIcon.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        
        //new pop up, if press cancel =>
        //stopIcon.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        StopGameViewController.instance.showAlert()
        
    }
    
//    func didYesButtonTapped() {
//        print("go back ples")
//        self.dismiss(animated: true, completion: nil)
//    }
    
    func didContinueButtonTapped() {
        stopIcon.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func didExitButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}
