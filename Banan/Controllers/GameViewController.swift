//
//  GameViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 01/04/2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, StopGameViewControllerDelegate, LevelDoneViewControllerDelegate, LevelFailViewControllerDelegate, Hint5ViewControllerDelegate, Hint4ViewControllerDelegate
, Hint3ViewControllerDelegate
{
    
    
    @IBOutlet weak var heart1: UIButton!
    @IBOutlet weak var heart2: UIButton!
    @IBOutlet weak var heart3: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var animalLabel: UILabel!
    
    
    @IBOutlet weak var stopIcon: UIButton!
    
    @IBOutlet weak var passedAnimals: UILabel!
    
    @IBOutlet weak var goodLabel: UILabel!
    
    @IBOutlet weak var goodLine: UIImageView!
    @IBOutlet weak var excellentLabel: UILabel!
    
    @IBOutlet weak var excellentLine: UIImageView!
    @IBOutlet weak var perfectLabel: UILabel!
    
    @IBOutlet weak var perfectLine: UIImageView!
    @IBOutlet weak var lineSuperView: UIView!
    
    @IBOutlet weak var labelSuperView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    
    var player: AVAudioPlayer?
    
    var completedGameAnimal = [[String:String]]()
    
    
    var allGameAnimals = [Game]()
    var allLetters: [Letters]?
    //from reema?
    var gameLevel =
    //[Game]()
    [
        Game(
            AllLetters:["Ayn","Sad","Faa","Waw","Raa"],
            Arabic: "عصفور",
            Level:"First",
            Points: "100",
            Animal: "Bird"),
        
        Game(
            AllLetters:["Baa","Gaf","Raa","Ttt"],
            Arabic: "بقرة",
            Level:"First",
            Points: "100",
            Animal: "Cow"),
        
//        Game(
//            AllLetters:["2lf","Sen","Dal"],
//            Arabic: "أسد",
//            Level:"First",
//            Points: "100",
//            Animal: "Lion"),


        Game(
            AllLetters:["Kaf","Lam","Baa"],
            Arabic: "كلب",
            Level:"First",
            Points: "130",
            Animal: "Dog"),

//        Game(
//            AllLetters:["Gaf","Raa","Dal"],
//            Arabic: "قرد",
//            Level:"First",
//            Points: "125",
//            Animal: "Monkey")
    ]
    //from reema
    var levelTitle = ""
    //"المستوى الأول"
    //form reema
    var levelNum = "First"
    
    
    var levelPoints = 0
    var levelUserPoints = 0
    var index = 0
    var numOfHeart = 3;
    var animalBraille = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player?.stop()
        
        levelTitle = ConvertLevel.FindLevelTitle(levelName: levelNum)
        //design progressbar
        designProgressbar()
        
        getChildData()
        getGameData()
        getLettersData()
//        groupByLevel()
        
        updatePassedLabel()
        updateAnimalInfo()
        
        if(index == gameLevel.count - 1){
            //last animal
            skipButton.isHidden = true
        }else{
            skipButton.isHidden = false
        }
        
        levelPoints = gameLevel.map({Int($0.Points)!}).reduce(0, +)
        levelUserPoints = gameLevel.map({$0.currentPoint}).reduce(0, +)
        
        
        
        StopGameViewController.instance.delegate = self
        LevelDoneViewController.instance.delegate = self
        LevelFailViewController.instance.delegate = self
        Hint5ViewController.instance.delegate = self
        Hint4ViewController.instance.delegate = self
        Hint3ViewController.instance.delegate = self

    }
//    func groupByLevel(){
//        gameLevel = allGameLevels.filter({$0.Level == levelNum})
//    }
    
    func getLettersData(){
        print("in getLettersData")
        let lett = LocalStorage.allLettersInfo
        if lett != nil{
            print("itsnill")
            allLetters = lett!
            //            print(allLetters)
            
        }
    }
    func getWordBraille(){
        // reset wordBraille
        animalBraille.removeAll()
        let animalLetter = gameLevel[index].AllLetters
        print("animal letter count:")
        print(animalLetter.count)
        for letterKey in animalLetter{
            let oneLetter = allLetters!.filter({$0.Letter == letterKey})
            print(oneLetter)
            let braille = oneLetter[0].Braille
                        print("what?")
                        print(braille)
            animalBraille.append(braille)
            
        }
        print("printin word braille")
        print(animalBraille)
    }
    func updateLevel(){
        gameLevel = allGameAnimals.filter({$0.Level == levelNum})
    }
    
    func designProgressbar(){
        
        goodLabel.layer.position = .init(x: labelSuperView.frame.width * (1-0.2), y: labelSuperView.frame.height/2)
                
        excellentLabel.layer.position = .init(x: labelSuperView.frame.width * (1-0.5), y: labelSuperView.frame.height/2)

        perfectLabel.layer.position = .init(x: labelSuperView.frame.width * (1-0.75), y: labelSuperView.frame.height/2)
        
        
        goodLine.layer.position = .init(x: lineSuperView.frame.width * (1-0.2), y: lineSuperView.frame.height/2)

        excellentLine.layer.position = .init(x: lineSuperView.frame.width * (1-0.5), y: lineSuperView.frame.height/2)

        perfectLine.layer.position = .init(x: lineSuperView.frame.width * (1-0.75), y: lineSuperView.frame.height/2)


        
        progressBar.layer.borderWidth = 5;
        progressBar.layer.borderColor =  UIColor(red:255/255, green:255/255, blue:255/255, alpha:1).cgColor
        // Set the rounded edge for the outer bar
        progressBar.layer.cornerRadius = 15
        progressBar.clipsToBounds = true
        
        // Set the rounded edge for the inner bar
        progressBar.layer.sublayers![1].cornerRadius = 15
        progressBar.subviews[1].clipsToBounds = true
        
        progressBar.transform = CGAffineTransform(rotationAngle: .pi);
        progressBar.layer.backgroundColor = UIColor(red:225/255, green:225/255, blue:225/255, alpha:1).cgColor
        
    }
    
    func getGameData(){
        print("in getLettersData")
        let game = LocalStorage.allGameInfo
        if game != nil{
            print("game")
            allGameAnimals = game!
            print(allGameAnimals)
            
        }
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
        print(gameLevel[index].Animal)
        animalImage.image = UIImage(named: "\(gameLevel[index].Animal)")
        
        animalLabel.text = gameLevel[index].Arabic
        
        //update num of hearts because its new animal
        numOfHeart = 3;
        updateHeart()
        getWordBraille()
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
            if(gameLevel[index].AllLetters.count == 5){
            Hint5ViewController.instance.showAlert(title: gameLevel[index].Arabic, brailleArray: animalBraille)
            }
            else if(gameLevel[index].AllLetters.count == 4){
            Hint4ViewController.instance.showAlert(title: gameLevel[index].Arabic, brailleArray: animalBraille)
            }
            else if(gameLevel[index].AllLetters.count == 3){
            Hint3ViewController.instance.showAlert(title: gameLevel[index].Arabic, brailleArray: animalBraille)
            }

        }
        else{
            print("no hearts left")
            numOfHeart = 3
            updateHeart()
        }
//        Hint5ViewController.instance.showAlert(title: gameLevel[index].Arabic, brailleArray: animalBraille)
    }
    
    @IBAction func pressCheck(_ sender: UIButton) {
        
        
        print("press check")
        
        //if the answer was correct, do the following
        print(gameLevel[index].Animal)
        var curPoints = Int(gameLevel[index].Points) ?? 0
        print(curPoints)
        //if num of heart == 0 ? (+20)
        curPoints = Int((Float(curPoints - 20 )/3.0) * Float(numOfHeart))
        curPoints += 20
        
        gameLevel[index].setCurrent(point: curPoints)
        print(curPoints)
        
        levelUserPoints = gameLevel.map({$0.currentPoint}).reduce(0, +)
        print("what")
        print(gameLevel[index].currentPoint)
        //update progresssbar
        progressBar.setProgress(Float(levelUserPoints)/Float(levelPoints), animated: true)
        
        //add animal to completed animals with point
        
        
        //if level did not finish
        if(index != gameLevel.count - 1){
            index = index + 1
            
            viewDidLoad()
        }
        //else pop up message with total points and pass or fail
        //total point in level
        else{
            var title = ""
            var imageName = ""
            //            var lev
            let userPercent = Float(levelUserPoints)/Float(levelPoints)
            if(userPercent < 0.2){
                title = "حاول مرة اخرى"
                levelTitle = "لم تكمل \(levelTitle)"
                
                imageName = "tryAgain"
                //diffrent pop up
                LevelFailViewController.instance.showAlert(title: title, level: "\(levelTitle)", gameArray: gameLevel, totalScore: levelUserPoints , imageName: imageName)
            }
            else
            {if (userPercent >= 0.2 && userPercent < 0.5 ){
                title = "جيد"
                levelTitle = "أكملت \(levelTitle)"
                imageName = "good"
            }
                else if (userPercent >= 0.5 && userPercent < 0.75 ){
                    title = "ممتاز"
                    levelTitle = "أكملت \(levelTitle)"
                    imageName = "excellent"
                    
                }else if (userPercent >= 0.75 ){
                    title = "رائع"
                    levelTitle = "أكملت \(levelTitle)"
                    imageName = "perfect"
                }
                LevelDoneViewController.instance.showAlert(title: title, level: "\(levelTitle)", gameArray: gameLevel, totalScore: levelUserPoints , imageName: imageName)
            }
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
    
    func didNextButtonTapped() {
        print("next pressed")
        index = 0
        levelNum = ConvertLevel.FindNextLevel(levelName: levelNum)
        progressBar.setProgress(0.0, animated: true)
        updateLevel()
        viewDidLoad()
    }
    
    func didRedoButtonTapped() {
        print("redo pressed")
        index = 0
        progressBar.setProgress(0.0, animated: true)
        gameLevel[0].currentPoint = 0
        gameLevel[1].currentPoint = 0
        gameLevel[2].currentPoint = 0

        viewDidLoad()
    }
    
}
