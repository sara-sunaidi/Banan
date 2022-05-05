//
//  LearnLetterViewController.swift
//  Banan
//
//  Created by Noura  on 10/08/1443 AH.
//

//import Foundation
import UIKit
import SwiftUI
//import AVFoundation
import Firebase

class LearnLetterViewController: UIViewController, CustomConfirmationViewControllerDelegate, CustomAlertViewControllerDelegate,LetterInstructionsViewControllerDelegate {
    func didDoneButtonTapped() {
        
    }
    
    
    var letters : [Letters]?
    var index: Int?
    var strLetter: String = "حرف "
//    var player: AVAudioPlayer?
    var expectedResult : String?
    var completedLetters: [String]?
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let db = Firestore.firestore()
    
    @IBOutlet weak var imageLetter: UIImageView!
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var progressView1: UIProgressView!
    
    @IBOutlet weak var block: UIView!
    
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
    
    @IBOutlet weak var checkBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound("\(letters![index!].Letter)")

        let lettersWithout = ["2aa", "Alf", "2lf", "Ttt"]
        
        if(index! == 0){
            prevLetterButton.isHidden = true
        }else {
            prevLetterButton.isHidden = false
        }
        
        if(lettersWithout.contains(letters![index!].Letter)){
            strLetter = ""
        }
        
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
        addShadowBtn(prevLetterButton)
        addShadowBtn(checkBtn)
        
        
        block.layer.cornerRadius = 10
        
        
        addColor(letters![index!].Braille)
       
        //animateProgress
        setProgress()
        
        CustomConfirmationViewController.instance.delegate = self
        CustomAlertViewController.instance.delegate = self
        LetterInstructionsViewController.instance.delegate = self
        LetterInstructionsViewController.instance.showAlert()
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("result"), object: nil)
    }
    
    @objc func didGetNotification(_ notification:Notification){
        let result = notification.object as! String?
        checkAnswer(result!)
    }
    
    private func checkAnswer(_ actualResult: String){
        
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
            
            expectedResult = getLetter(letters![index!].Arabic)
            
            print("- actualResult is \(actualResult)")
            
            print("- in CheckAnswer ELSE")
            
            // Correct Answer
            if (actualResult == expectedResult){
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
        // فاصل
    }
    
    func getLetter(_ s: String)-> String{
        switch s {
        case "الهمزة المفردة":
            return "ء"
        case "الألف بهمزة":
            return "أ"
        case "الطاء":
            return "ط"
        case "الحاء":
            return "ح"
        case "الألف المقصورة":
            return "ى"
        case "الألف بدون همزة":
            return "ا"
        case "العين":
            return "ع"
        case "الباء":
            return "ب"
        case "الدال":
            return "د"
        case "الظاء":
            return "ظ"
        case "الضاد":
            return "ض"
        case "الفاء":
            return "ف"
        case "القاف":
            return "ق"
        case "الغين":
            return "غ"
        case "الهاء":
            return "ه"
        case "الجيم":
            return "ج"
        case "الكاف":
            return "ك"
        case "الخاء":
            return "خ"
        case "اللام":
            return "ل"
        case "الميم":
            return "م"
        case "النون":
            return "ن"
        case "الراء":
            return "ر"
        case "الصاد":
            return "ص"
        case "السين":
            return "س"
        case "الشين":
            return "ش"
        case "التاء":
            return "ت"
        case "الثاء":
            return "ث"
        case "الذال":
            return "ذ"
        case  "التاء المربوطة":
            return "ة"
        case "الياء":
            return "ي"
        case "الواو":
            return "و"
        case "الزاي":
            return "ز"
        default:
            return "- not found in switch"
        }
    }
    
    private func correctAnswer(){
        // Call pop up
        CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
        
        // # update user info
        if(appdelegate.isChild){
            FirebaseRequest.updateCompletedLetter(letter: letters![index!].Letter, level: letters![index!].Level)}
        
        //play sound
        playSound("Correct")
        //animate progress
        animateProgress()
    }
    
    @IBAction func pressSound(_ sender: UIButton) {
        playSound("\(letters![index!].Letter)")
    }
    // add shadow to circle
    func addShadow(_ crl: UIButton){
        crl.backgroundColor = UIColor(red: 28/255, green: 0/255, blue: 0/255, alpha: 0.5)
        crl.layer.borderWidth = 5
        crl.layer.borderColor = UIColor(red: 207/255, green: 190/255, blue: 170/255, alpha: 1.0).cgColor
        
        crl.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        crl.layer.shadowOffset = CGSize(width: 1, height: 2)
        crl.layer.shadowOpacity = 0
        crl.layer.shadowRadius = 0.0
        crl.layer.masksToBounds = false
//        crl.frame = CGRect(width: 50, height: 50)

        
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
                    circle1.backgroundColor = UIColor(named: "Color4")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle1.layer.borderWidth = 4
                    circle1.layer.borderColor = UIColor(red: 226/255, green: 59/255, blue: 18/255, alpha: 1.0).cgColor
                    circle1.layer.cornerRadius = 0.5 * circle1.bounds.size.width
                    circle1.layer.shadowOpacity = 2
                    
                }
                else if(i==1){
                    circle2.backgroundColor = UIColor(named: "Color4")
                    //UIColor(red:118/255, green:168/255, blue:158/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle2.layer.borderWidth = 4
                    circle2.layer.borderColor = UIColor(red: 226/255, green: 59/255, blue: 18/255, alpha: 1.0).cgColor
                    circle2.layer.cornerRadius = 0.5 * circle2.bounds.size.width
                    circle2.layer.shadowOpacity = 2
                }
                else if(i==2){
                    circle3.backgroundColor = UIColor(named: "Color4")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle3.layer.borderWidth = 4
                    circle3.layer.borderColor = UIColor(red: 226/255, green: 59/255, blue: 18/255, alpha: 1.0).cgColor

                    circle3.layer.cornerRadius = 0.5 * circle3.bounds.size.width
                    circle3.layer.shadowOpacity = 2
                }
                else if(i==3){
                    circle4.backgroundColor = UIColor(named: "Color4")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle4.layer.borderWidth = 4
                    circle4.layer.borderColor = UIColor(red: 226/255, green: 59/255, blue: 18/255, alpha: 1.0).cgColor
                    circle4.layer.cornerRadius = 0.5 * circle4.bounds.size.width
                    circle4.layer.shadowOpacity = 2
                }
                else if(i==4){
                    circle5.backgroundColor = UIColor(named: "Color4")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle5.layer.borderWidth = 4
                    circle5.layer.borderColor = UIColor(red: 226/255, green: 59/255, blue: 18/255, alpha: 1.0).cgColor
                    circle5.layer.cornerRadius = 0.5 * circle5.bounds.size.width
                    circle5.layer.shadowOpacity = 2
                }
                else{
                    circle6.backgroundColor = UIColor(named: "Color4")
                    //UIColor(red:193/255, green:222/255, blue:183/255, alpha:1)
                    //circle1.layer.cornerRadius = 5
                    circle6.layer.borderWidth = 4
                    circle6.layer.borderColor = UIColor(red: 226/255, green: 59/255, blue: 18/255, alpha: 1.0).cgColor
                    circle6.layer.cornerRadius = 0.5 * circle6.bounds.size.width
                    circle6.layer.shadowOpacity = 2
                }
            }
        }
    }
    
    // play sound
    func playSound(_ name:String) {
        PlayAllSounds.sharedInstance.stop()
        PlayAllSounds.sharedInstance.play(name: name)
//        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3")
//        else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let player = player else { return }
//
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
        
    }
    
    func getChildData(){
        let child = LocalStorage.childValue
        if child != nil {
            setChildInfo(child: child!)
        }
        
    }

    func setChildInfo(child: Child){
        self.completedLetters = child.completedLetters
        
    }
    // set progress bar
    func setProgress(){
        getChildData()
        var levelArray = [Letters?]()
        levelArray = letters!
//        let filteredArray = levelArray.map{$0.Letter}
        let filteredArray = levelArray.map{$0!.Letter}
        let intersect = Set(filteredArray).intersection(completedLetters ?? []).count
        
        progressView1.setProgress((Float(intersect) / Float(letters?.count ?? 1)), animated: true)
    }
    
    // animate progress bar
    func animateProgress(){
        setProgress()
//        let i = 1/Float(letters?.count ?? 1)
//        progressView1.setProgress(i, animated: true)
    }
    
    @IBAction func pressBack(_ sender: UIButton) {
        //        self.dismiss(animated: true, completion: nil)
        CustomConfirmationViewController.instance.showAlert(title: "تنبيه", message: "هل تود الخروج من الكلمة الحالية؟")
    }
    
    @IBAction func pressPreviousLetter(_ sender: UIButton) {
        index = index! - 1
        strLetter = "حرف "
        
        viewDidLoad()
    }
    
    @IBAction func pressCheckAnswer(_ sender: Any) {
        print("## in Check")
        takePhotoVC.checkCameraPermissions()
        let timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            takePhotoVC.didTapCheck()
        }
        
    }
    
    func didYesButtonTapped() {
//        player?.stop()
        PlayAllSounds.sharedInstance.stop()
        self.dismiss(animated: true, completion: nil)
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
    
    func didExitButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didContinueButtonTapped() {
        if (index == (letters!.count)-1){
            self.dismiss(animated: true, completion: nil)
        }else {
            index = index! + 1
            strLetter = "حرف "
            viewDidLoad()
        }
        
    }
    
    func didRedoButtonTapped() {
        strLetter = "حرف "
        viewDidLoad()
    }
    @IBAction func instructionButtonPressed(_ sender: UIButton) {
        LetterInstructionsViewController.instance.showAlert()
    }
}



//CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
