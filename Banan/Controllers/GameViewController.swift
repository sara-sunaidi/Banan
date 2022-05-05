//
//  GameViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 01/04/2022.
//
import UIKit
//import AVFoundation


class GameViewController: UIViewController, StopGameViewControllerDelegate, LevelDoneViewControllerDelegate, LevelFailViewControllerDelegate, Hint5ViewControllerDelegate, Hint4ViewControllerDelegate
, Hint3ViewControllerDelegate,GameInstructionsViewControllerDelegate
{
 
    
    
    
    @IBOutlet weak var heart1: UIButton!
    @IBOutlet weak var heart2: UIButton!
    @IBOutlet weak var heart3: UIButton!
    
    @IBOutlet weak var hintBtn: UIButton!

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
        
    
    var GameLevels = [[String:String]]() //levels that the user played, from db-localstorage
    
    var allGameAnimals = [Game]() //all the animals, from db-localstorage
    
    var allLetters: [Letters]? //al letters from db-local storage
    
    
    var currentLevel: [Game]! //from reema, array of three animals for chosen level
    
    var levelNum : String! //form reema, the level number like First, Second ...
    
    var levelTitle = ""
    
    var expectedResult : String?

    
    var levelPoints = 0 //full level points
    var levelUserPoints = 0
    var index = 0
    var numOfPassed = 0
    var numOfHeart = 3;
    var animalBraille = [String]() // braille representation for current animal
    var isLastLevel = false //weather we are in the last level or not
    let gameOverSoundName = "GameOver"
    let winSoundName = "WinLastLevel"
    let winAnyLevelSoundName = "WinAnyLevel"
    
    var LevelNumber : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        designProgressbar() //design progressbar
        getChildData()
        getGameData()
    }
    
    func didDoneButtonTapped() {//??
    
    }
    //no need, the user cannot change the orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [self] (UIViewControllerTransitionCoordinatorContext) -> Void in
            print("in will trans")
            
            designBarLabels()
            
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                
            case .portrait:
                
                print("Portrait")
                print("gg1: ")
                print(self.labelSuperView.frame.width)
                
            case .landscapeLeft,.landscapeRight :
                
                print("Landscape")
                print("gg2: ")
                print(self.labelSuperView.frame.width)
                
            default:
                
                print("Anything But Portrait")
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        print("in did appear")
        designProgressbar()
        designBarLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        player?.stop()
        PlayAllSounds.sharedInstance.stop() //stop any prev animal sound
        
        
        updateLevelInfo()
        designProgressbar() //design progressbar
        designBarLabels() //can be merge with progress bar because the orientation will not change
        
        getChildData()
        getGameData()
        getLettersData()
        
        updatePassedLabel()
        updateAnimalInfo()
        
        
        levelPoints = currentLevel?.map({Int($0.Points)!}).reduce(0, +) ?? 0
        levelUserPoints = currentLevel?.map({$0.currentPoint}).reduce(0, +) ?? 0
        
        
        if(index == currentLevel?.count ?? 0 - 1 ){
            //last animal
            skipButton.isHidden = true
        }else{
            skipButton.isHidden = false
        }
        
        StopGameViewController.instance.delegate = self
        LevelDoneViewController.instance.delegate = self
        LevelFailViewController.instance.delegate = self
        Hint5ViewController.instance.delegate = self
        Hint4ViewController.instance.delegate = self
        Hint3ViewController.instance.delegate = self
        GameInstructionsViewController.instance.delegate = self
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("result"), object: nil)
        
        if(GameLevels.count<1){
            GameInstructionsViewController.instance.showAlert() }// need update
    
    }
    
    func updateLevelInfo(){
        
        levelTitle = ConvertLevel.FindLevelTitle(levelName: levelNum ?? "")
        let allLevels = allGameAnimals.map({$0.Level})
        isLastLevel = ConvertLevel.isLastLevel(availableLvels: allLevels, currentLevel: levelNum ?? "")
        
    }
    
    @objc func didGetNotification(_ notification:Notification){
        let result = notification.object as! String?
        checkAnswer(result!)
    }
    
     func checkAnswer(_ actualResult: String){
        
        print("- in CheckAnswer")
        
        if (actualResult == "failed"){
            // Incorrect placment of pieces
            print("- in CheckAnswer result is FAILED")
            // call toast
            let viewModel: SnackbarViewModel
            
            viewModel = SnackbarViewModel(text: "رجاءً تأكد من وضع القطع في مكانها الصحيح !", image: UIImage(named: "Warning"))
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
            let snackbar = SnackbarView(viewModel: viewModel, frame: frame, color: .yellow)
            showSnackbar(snackbar: snackbar)
            
        } else{
            
            expectedResult = currentLevel![index].Arabic
            
            print("- actualResult is \(actualResult)")
            
            print("- in CheckAnswer ELSE")
            
            // Correct Answer
            if (actualResult == expectedResult){
//                playSound("Correct")
                correctAnswer()
            }
            // Incorrect Answer
            else{
                
                // Snackbar calling is here
                let viewModel: SnackbarViewModel
                
                viewModel = SnackbarViewModel(text: "\"\(actualResult)\" إجابة خاطئة ... حاول مرة أخرى !", image: UIImage(named: "wrongAnswer"))
                
                let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
                let snackbar = SnackbarView(viewModel: viewModel, frame: frame, color: .red)
                showSnackbar(snackbar: snackbar)
                
                //play sound
                playSound("Incorrect")

            }
            
            
        }
    }
    
    private func correctAnswer(){
        //play sound
        playSound("Correct")
        
        //if the answer was correct, do the following
        //claculate points
        
        numOfPassed = numOfPassed + 1
        updatePassedLabel()
        
        calculatePoints()
        
//        levelUserPoints = currentLevel.map({$0.currentPoint}).reduce(0, +)

        
        //update progresssbar
        progressBar.setProgress(Float(levelUserPoints)/Float(levelPoints), animated: true)
        
        
        //if level did not finish
        if(index != currentLevel.count - 1){
//            // Call pop up
//            CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
            
            // Snackbar calling is here
            let viewModel: SnackbarViewModel
            
            viewModel = SnackbarViewModel(text: "أحسنت ... إجابة صحيحة", image: UIImage(named: "excellent"))
            
            let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
            let snackbar = SnackbarView(viewModel: viewModel, frame: frame, color: .green)
            showSnackbar(snackbar: snackbar)
            
            index = index + 1
            
            playSound("Correct")
            let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { timer in
                self.viewDidLoad()
            }
            
        }
        else{
            //else pop up message with total points and pass or fail
            //total point in level
            finishLevel()
        }
    }
    func calculatePoints(){
        
        var curPoints = Int(currentLevel[index].Points) ?? 0 //full point for current animal
        
        curPoints = Int((Float(curPoints - 20 )/3.0) * Float(numOfHeart))
        curPoints += 20 // because the answer was currect
        
        currentLevel[index].setCurrent(point: curPoints) // save current point locally
        
        levelUserPoints = currentLevel.map({$0.currentPoint}).reduce(0, +)
    }
    
    public func showSnackbar(snackbar: SnackbarView){
        
        let width = view.frame.size.width/1.5
        
        // set frame to start position
        snackbar.frame = CGRect(
            x: (view.frame.size.width-width)/2,
            y: view.frame.size.height,
            width: width,
            height: 130)
        
        view.addSubview(snackbar)
        
        // animate it upwards
        UIView.animate(withDuration: 0.5, animations: {
            snackbar.frame = CGRect(
                x: (self.view.frame.size.width-width)/2,
                y: self.view.frame.size.height - 140,
                width: width,
                height: 130)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    
                    // animate it downwards
                    UIView.animate(withDuration: 0.7, animations: {
                        snackbar.frame = CGRect(
                            x: (self.view.frame.size.width-width)/2,
                            y: self.view.frame.size.height,
                            width: width,
                            height: 130)
                    }, completion: { finished in
                        if finished{
                            snackbar.removeFromSuperview()
                        }
                        
                    })
                })
                
                
            }
        })
    }
    
    func designBarLabels(){
        goodLabel.layer.position = .init(x: labelSuperView.frame.width * (1-0.2), y: labelSuperView.frame.height/2)
        
        excellentLabel.layer.position = .init(x: labelSuperView.frame.width * (1-0.5), y: labelSuperView.frame.height/2)
        
        perfectLabel.layer.position = .init(x: labelSuperView.frame.width * (1-0.75), y: labelSuperView.frame.height/2)
        
        
        goodLine.layer.position = .init(x: lineSuperView.frame.width * (1-0.2), y: lineSuperView.frame.height/2)
        
        excellentLine.layer.position = .init(x: lineSuperView.frame.width * (1-0.5), y: lineSuperView.frame.height/2)
        
        perfectLine.layer.position = .init(x: lineSuperView.frame.width * (1-0.75), y: lineSuperView.frame.height/2)
        //
        
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
        progressBar.layer.backgroundColor = UIColor(red:225/255, green:225/255, blue:225/255, alpha:1).cgColor
        
    }
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            self.GameLevels = child!.GameLevels
        }
    }
    
    func getGameData(){
        let game = LocalStorage.allGameInfo
        if game != nil{
            allGameAnimals = game!
        }
    }
    
    func getLettersData(){
        let lett = LocalStorage.allLettersInfo
        if lett != nil{
            allLetters = lett!
        }
    }
    
    func updatePassedLabel(){
        let arabicPassed = "\(numOfPassed)".convertedDigitsToLocale(Locale(identifier: "AR"))
        let arabicTotal = "\(currentLevel?.count ?? 0)".convertedDigitsToLocale(Locale(identifier: "AR"))
        
        passedAnimals.text = "\(arabicTotal)/\(arabicPassed)"
    }
    
    func updateAnimalInfo(){
        
        //start current animal sound?
        playSound("\(currentLevel?[index].Animal ?? "")-Game")
        
        animalImage.image = UIImage(named: "\(currentLevel?[index].Animal ?? "")")
        
        animalLabel.text = currentLevel?[index].Arabic ?? ""
        
        //update num of hearts because its new animal
        numOfHeart = 3;
        updateHeart()
        getWordBraille()
    }
    
    func getWordBraille(){
        // reset wordBraille
        animalBraille.removeAll()
        
        let animalLetter = currentLevel?[index].AllLetters ?? []
        
        for letterKey in animalLetter{
            let oneLetter = allLetters!.filter({$0.Letter == letterKey})
            
            let braille = oneLetter[0].Braille
            
            animalBraille.append(braille)
            
        }
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
    
    func updateLevel(){
        currentLevel = allGameAnimals.filter({$0.Level == levelNum})
    }
    
    @IBAction func pressSpeaker(_ sender: UIButton) {
        print("play sound")
        playSound("\(currentLevel[index].Animal)-Game")
    }
    func playSound(_ name:String){
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: name)
    }
    
    @IBAction func pressInstructions(_ sender: UIButton) {
        
        GameInstructionsViewController.instance.showAlert()
    }
    
    @IBAction func pressHint(_ sender: UIButton) {
        
        print("press hint")
        if(numOfHeart != 0){
            numOfHeart = numOfHeart - 1
            updateHeart()
            
            if(currentLevel[index].AllLetters.count == 5){
                Hint5ViewController.instance.showAlert(title: currentLevel[index].Arabic, brailleArray: animalBraille)
            }
            else if(currentLevel[index].AllLetters.count == 4){
                Hint4ViewController.instance.showAlert(title: currentLevel[index].Arabic, brailleArray: animalBraille)
            }
            else if(currentLevel[index].AllLetters.count == 3){
                Hint3ViewController.instance.showAlert(title: currentLevel[index].Arabic, brailleArray: animalBraille)
            }
            
        }
        else{
            print("no hearts left")
            CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "لم يتبقى لديك أي محاولة" ,acknowledgementType: .negative)
        }
    }
    
    @IBAction func pressCheck(_ sender: UIButton) {
        
        print("press check")
        takePhotoVC.checkCameraPermissions()
        let timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            takePhotoVC.didTapCheck()
        }
    }
    
    
    func finishLevel(){
        
        var title = ""
        var imageName = ""
        let userPercent = Float(levelUserPoints)/Float(levelPoints)
        var levelPassed = false
        var nextLevelAvailable = false
        
        let animalLevel = GameLevels.filter({$0["Level"] == levelNum})
        if(userPercent < 0.2){
            title = "حاول مرة اخرى"
            levelTitle = "لم تكمل \(levelTitle)"
            
            imageName = "tryAgain"
            levelPassed = false
            print("in try again")
        }
        else
        {
            levelTitle = "أكملت \(levelTitle)"
            levelPassed = true

            if (userPercent >= 0.2 && userPercent < 0.5 ){
                title = "جيد"
//                levelTitle = "أكملت \(levelTitle)"
                imageName = "good"
            }
            else if (userPercent >= 0.5 && userPercent < 0.75 ){
                title = "ممتاز"
                levelTitle = "أكملت \(levelTitle)"
//                imageName = "excellent"
                
            }else if (userPercent >= 0.75 ){
                title = "رائع"
//                levelTitle = "أكملت \(levelTitle)"
                imageName = "perfect"
            }
        }
        
        if (animalLevel.count != 0) {
            //means it is already stored in database, either passed or not
            if(Float(animalLevel[0]["Score"]!)! > 0.2) {
                print("next is available")
                nextLevelAvailable = true
            }
            
            let oldScore = Float(animalLevel[0]["Score"]!)!
            print("there is points")
            if(oldScore < userPercent){
                print("change in db")
                FirebaseRequest.updateGameLevels(levelName: levelNum!,
                                                 score: Float(round(1000 * userPercent) / 1000),
                                                 userPoints: levelUserPoints,
                                                 eval: title ,
                                                 oldData: animalLevel[0])
            }
        }else{
            //not stored yet
            if (levelPassed){
                nextLevelAvailable = true
                //add to db
                //should be added even if level not pased? need to test
                FirebaseRequest.addGameLevels(levelName: levelNum ?? "",
                                              score: Float(round(1000 * userPercent) / 1000),
                                              userPoints: levelUserPoints,
                                              eval: title)
            }
        }
        
        if(isLastLevel){
            //change the sounds
            if(levelPassed){
                LevelFailViewController.instance.showAlert(title: "مبهر!", level: "أكملت جميع المستويات", gameArray: currentLevel, totalScore: levelUserPoints , imageName: "medal", soundName: winSoundName)
            }
            else{
                LevelFailViewController.instance.showAlert(title: title, level: "\(levelTitle)", gameArray: currentLevel, totalScore: levelUserPoints , imageName: imageName, soundName: gameOverSoundName)
            }
        }
        else{ //not last level
            if(nextLevelAvailable){
                LevelDoneViewController.instance.showAlert(title: title, level: "\(levelTitle)", gameArray: currentLevel, totalScore: levelUserPoints , imageName: imageName, soundName: levelPassed ? winSoundName : gameOverSoundName)
            }else{
                LevelFailViewController.instance.showAlert(title: title, level: "\(levelTitle)", gameArray: currentLevel, totalScore: levelUserPoints , imageName: imageName, soundName: gameOverSoundName)
            }
        }
    }
    
    @IBAction func pressSkip(_ sender: UIButton) {
        
        print("press skip")
        if(index != currentLevel.count - 1){
            index += 1
            viewDidLoad()
        }
        
    }
    
    @IBAction func pressStop(_ sender: UIButton) {
        
        //        player?.stop()
        PlayAllSounds.sharedInstance.stop()
        
        print("press stop")
        stopIcon.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        
        StopGameViewController.instance.showAlert()
        
    }
    
    func didContinueButtonTapped() {
        stopIcon.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func didExitButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didNextButtonTapped() {
        print("next level pressed")
        numOfPassed = 0
        index = 0
        levelNum = ConvertLevel.FindNextLevel(levelName: levelNum!)
        progressBar.setProgress(0.0, animated: true)
        updateLevel()
        viewDidLoad()
    }
    
    func didRedoButtonTapped() {
        print("redo pressed")
        numOfPassed = 0
        index = 0
        progressBar.setProgress(0.0, animated: true)
        currentLevel[0].currentPoint = 0
        currentLevel[1].currentPoint = 0
        currentLevel[2].currentPoint = 0
        
        viewDidLoad()
    }
    
}
