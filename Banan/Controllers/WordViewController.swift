//
//  WordViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
//
//
//  WordViewController.swift
//  Banan
//
//  Created by Noura  on 15/08/1443 AH.
//


import UIKit
import Firebase


class WordViewController: UIViewController, UINavigationControllerDelegate, CustomAlertViewControllerDelegate, CustomConfirmationViewControllerDelegate {
    
    
    @IBOutlet weak var fourLetttersView: UIView!
    var allWords : [Words]?
    var index: Int?
    var allLetters: [Letters]?
    var wordBraille = [String]()
    let db = Firestore.firestore()
    var expectedResult : String?
    
    //four letters
    
    @IBOutlet weak var fourLabel1: UILabel!
    @IBOutlet weak var fourLabel2: UILabel!
    @IBOutlet weak var fourLabel3: UILabel!
    @IBOutlet weak var fourLabel4: UILabel!
    
    
    @IBOutlet weak var fourblock1: UIView!
    @IBOutlet weak var fourblock2: UIView!
    @IBOutlet weak var fourblock3: UIView!
    @IBOutlet weak var fourblock4: UIView!
    
    @IBOutlet weak var fourC1: UIButton!
    @IBOutlet weak var fourC2: UIButton!
    @IBOutlet weak var fourC3: UIButton!
    @IBOutlet weak var fourC4: UIButton!
    @IBOutlet weak var fourC5: UIButton!
    @IBOutlet weak var fourC6: UIButton!
    
    
    @IBOutlet weak var fourC11: UIButton!
    @IBOutlet weak var fourC22: UIButton!
    @IBOutlet weak var fourC33: UIButton!
    @IBOutlet weak var fourC44: UIButton!
    @IBOutlet weak var fourC55: UIButton!
    @IBOutlet weak var fourC66: UIButton!
    
    
    @IBOutlet weak var fourC111: UIButton!
    @IBOutlet weak var fourC222: UIButton!
    @IBOutlet weak var fourC333: UIButton!
    @IBOutlet weak var fourC444: UIButton!
    @IBOutlet weak var fourC555: UIButton!
    @IBOutlet weak var fourC666: UIButton!
    
    
    @IBOutlet weak var fourC1111: UIButton!
    @IBOutlet weak var fourC2222: UIButton!
    @IBOutlet weak var fourC3333: UIButton!
    @IBOutlet weak var fourC4444: UIButton!
    @IBOutlet weak var fourC5555: UIButton!
    @IBOutlet weak var fourC6666: UIButton!
    
    //
    @IBOutlet weak var block1: UIView!
    @IBOutlet weak var block2: UIView!
    @IBOutlet weak var block3: UIView!
    @IBOutlet weak var block4: UIView!
    @IBOutlet weak var block5: UIView!
    
    //letters of word
    @IBOutlet weak var letter1: UILabel!
    @IBOutlet weak var letter2: UILabel!
    @IBOutlet weak var letter3: UILabel!
    @IBOutlet weak var letter4: UILabel!
    @IBOutlet weak var letter5: UILabel!
    
    // braille block
    @IBOutlet weak var cr1: UIButton!
    @IBOutlet weak var cr2: UIButton!
    @IBOutlet weak var cr3: UIButton!
    @IBOutlet weak var cr4: UIButton!
    @IBOutlet weak var cr5: UIButton!
    @IBOutlet weak var cr6: UIButton!
    
    
    @IBOutlet weak var cr11: UIButton!
    @IBOutlet weak var cr22: UIButton!
    @IBOutlet weak var cr33: UIButton!
    @IBOutlet weak var cr44: UIButton!
    @IBOutlet weak var cr55: UIButton!
    @IBOutlet weak var cr66: UIButton!
    
    
    @IBOutlet weak var cr111: UIButton!
    @IBOutlet weak var cr222: UIButton!
    @IBOutlet weak var cr333: UIButton!
    @IBOutlet weak var cr444: UIButton!
    @IBOutlet weak var cr555: UIButton!
    @IBOutlet weak var cr666: UIButton!
    
    
    @IBOutlet weak var cr1111: UIButton!
    @IBOutlet weak var cr2222: UIButton!
    @IBOutlet weak var cr3333: UIButton!
    @IBOutlet weak var cr4444: UIButton!
    @IBOutlet weak var cr5555: UIButton!
    @IBOutlet weak var cr6666: UIButton!
    
    
    @IBOutlet weak var cr11111: UIButton!
    @IBOutlet weak var cr22222: UIButton!
    @IBOutlet weak var cr33333: UIButton!
    @IBOutlet weak var cr44444: UIButton!
    @IBOutlet weak var cr55555: UIButton!
    @IBOutlet weak var cr66666: UIButton!
    
    @IBOutlet weak var speakerBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var preWordButton: CustomButton!
    
    
    override func viewDidLoad() {
        print("- in view load WORD")
        super.viewDidLoad()
        
        if(index! == 0){
            
            preWordButton.isHidden = true
            
        }else {
            preWordButton.isHidden = false
        }
        
        hideCircle()
        
        addShadow(cr1)
        addShadow(cr2)
        addShadow(cr3)
        addShadow(cr4)
        addShadow(cr5)
        addShadow(cr6)
        addShadow(cr11)
        addShadow(cr22)
        addShadow(cr33)
        addShadow(cr44)
        addShadow(cr55)
        addShadow(cr66)
        addShadow(cr111)
        addShadow(cr222)
        addShadow(cr333)
        addShadow(cr444)
        addShadow(cr555)
        addShadow(cr666)
        addShadow(cr1111)
        addShadow(cr2222)
        addShadow(cr3333)
        addShadow(cr4444)
        addShadow(cr5555)
        addShadow(cr6666)
        addShadow(cr11111)
        addShadow(cr22222)
        addShadow(cr33333)
        addShadow(cr44444)
        addShadow(cr55555)
        addShadow(cr66666)
        //
        addShadow(fourC1)
        addShadow(fourC2)
        addShadow(fourC3)
        addShadow(fourC4)
        addShadow(fourC5)
        addShadow(fourC6)
        
        addShadow(fourC11)
        addShadow(fourC22)
        addShadow(fourC33)
        addShadow(fourC44)
        addShadow(fourC55)
        addShadow(fourC66)
        
        addShadow(fourC111)
        addShadow(fourC222)
        addShadow(fourC333)
        addShadow(fourC444)
        addShadow(fourC555)
        addShadow(fourC666)
        
        addShadow(fourC1111)
        addShadow(fourC2222)
        addShadow(fourC3333)
        addShadow(fourC4444)
        addShadow(fourC5555)
        addShadow(fourC6666)
        
        block1.layer.cornerRadius = 10
        block2.layer.cornerRadius = 10
        block3.layer.cornerRadius = 10
        block4.layer.cornerRadius = 10
        block5.layer.cornerRadius = 10
        
        fourblock1.layer.cornerRadius = 10
        fourblock2.layer.cornerRadius = 10
        fourblock3.layer.cornerRadius = 10
        fourblock4.layer.cornerRadius = 10
        
        CustomAlertViewController.instance.delegate = self
        CustomConfirmationViewController.instance.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("result"), object: nil)
        
        
        //add word image
        let image = UIImage(named: "\(allWords![index!].imageName)")
        print("printing the img")
        print(image)
        imageView.image = image
        //add word label
        wordLabel.text = allWords![index!].Arabic
        
        getLettersData()
        getWordBraille()
        
        showCircle(wordBraille.count)
        
    }
    
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
        wordBraille.removeAll()
        let wordLetter = allWords![index!].AllLetters
        
        for letterKey in wordLetter{
            let oneLetter = allLetters!.filter({$0.Letter == letterKey})
            let braille = oneLetter[0].Braille
            //            print("what?")
            //            print(braille)
            wordBraille.append(braille)
            
        }
        print("printin word braille")
        print(wordBraille)
    }
    
    @objc func didGetNotification(_ notification:Notification){
        let result = notification.object as! String?
        checkAnswer(result!)
    }
    
    
    @IBAction func checkAnswerBtn(_ sender: Any) {
        print("- in checkAnswerBtn")
        //        let takeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TakePhotoController") as! TakePhotoController
        takePhotoVC.checkCameraPermissions()
        let timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { timer in
            takePhotoVC.didTapCheck()
        }
        
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
            
            expectedResult = allWords![index!].Arabic
            
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
                
                viewModel = SnackbarViewModel(text: "\(actualResult) إجابة خاطئة ... حاول مرة أخرى !", image: UIImage(named: "wrongAnswer"))
                
                let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
                let snackbar = SnackbarView(viewModel: viewModel, frame: frame, color: .red)
                showSnackbar(snackbar: snackbar)
            }
            
            
        }
        
    }
    
    private func correctAnswer(){
        
        // Call pop up
        CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .word)
        
        updateCompletedWord()
    }
    
    func updateCompletedWord(){
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = self.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            thisUserDoc.updateData([
                "CompletedWord": FieldValue.arrayUnion([allWords![index!].Word])
            ])
        }
    }
    
    @IBAction func onClickPreWord(_ sender: Any) {
        index = index! - 1
        viewDidLoad()
        
    }
    @IBAction func onClickExit(_ sender: Any) {
        print("- in original exit btn")
        CustomConfirmationViewController.instance.showAlert(title: "تنبيه", message: "هل تود الخروج من الكلمة الحالية؟")
    }
    @IBAction func onClickSpeaker(_ sender: Any) {
        // # play audio
    }
    
    @IBAction func onClickGuide(_ sender: Any) {
        // # will be implemented in Group4
    }
    
    
    // The coming three methods to handle correct answer pop-up actions
    
    func didContinueButtonTapped() {
        print("- Continue tapped in word controller")
        if (index == (allWords!.count)-1){
            // if it was the last word in the category
            self.dismiss(animated: true, completion: nil)
        }else {
            index = index! + 1
            viewDidLoad()
        }
        
    }
    func didRedoButtonTapped() {
        print("- Redo tapped in word controller")
        viewDidLoad()
        
        
    }
    func didExitButtonTapped() {
        print("- Exit tapped in word controller")
        self.dismiss(animated: true, completion: nil)
    }
    
    // The coming method to handle exit confirmation pop-up actions
    
    func didYesButtonTapped() {
        print("- Yes tapped in word controller")
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
                    UIView.animate(withDuration: 0.5, animations: {
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
    
    // show circle
    func showCircle(_ num: Int){
        //        fourLetttersView.layer.position = .init(x: superView.frame.width/1.6, y: superView.frame.height/1.45)
        let wordArabic = allWords![index!].Arabic
        var wordArray = Array(wordArabic)
        if(num == 3){
            
            setBraille(cr11,cr22,cr33,cr44,cr55,cr66,wordBraille[0],letter2,wordArray[0], block: block2)
            setBraille(cr111,cr222,cr333,cr444,cr555,cr666,wordBraille[1],letter3,wordArray[1], block: block3)
            setBraille(cr1111,cr2222,cr3333,cr4444,cr5555,cr6666,wordBraille[2],letter4,wordArray[2], block: block4)
        }
        else if(num == 4){
            //            block2.layer.position = .init(x= )
            //            fourLetttersView.layer.position = .init(x: superView.frame.width/2, y: fourLetttersView.layer.position.y)
            
            setBraille(fourC1,fourC2,fourC3,fourC4,fourC5,fourC6,wordBraille[0],fourLabel1,wordArray[0],block: fourblock1)
            setBraille(fourC11,fourC22,fourC33,fourC44,fourC55,fourC66,wordBraille[1],fourLabel2,wordArray[1], block: fourblock2)
            setBraille(fourC111,fourC222,fourC333,fourC444,fourC555,fourC666,wordBraille[2],fourLabel3,wordArray[2], block: fourblock3)
            setBraille(fourC1111,fourC2222,fourC3333,fourC4444,fourC5555,fourC6666,wordBraille[3],fourLabel4,wordArray[3], block: fourblock4)
        }
        else{
            
            setBraille(cr1,cr2,cr3,cr4,cr5,cr6,wordBraille[0],letter1,wordArray[0], block: block1)
            setBraille(cr11,cr22,cr33,cr44,cr55,cr66,wordBraille[1],letter2,wordArray[1],block: block2)
            setBraille(cr111,cr222,cr333,cr444,cr555,cr666,wordBraille[2],letter3,wordArray[2],block: block3)
            setBraille(cr1111,cr2222,cr3333,cr4444,cr5555,cr6666,wordBraille[3],letter4,wordArray[3], block: block4)
            setBraille(cr11111,cr22222,cr33333,cr44444,cr55555,cr66666,wordBraille[4],letter5,wordArray[4], block: block5)
        }
        
    }
    
    // hide circle
    func hideCircle(){
        fourblock1.isHidden = true
        fourblock2.isHidden = true
        fourblock3.isHidden = true
        fourblock4.isHidden = true
        
        fourC1.isHidden = true
        fourC2.isHidden = true
        fourC3.isHidden = true
        fourC4.isHidden = true
        fourC5.isHidden = true
        fourC6.isHidden = true
        
        fourC11.isHidden = true
        fourC22.isHidden = true
        fourC33.isHidden = true
        fourC44.isHidden = true
        fourC55.isHidden = true
        fourC66.isHidden = true
        
        fourC111.isHidden = true
        fourC222.isHidden = true
        fourC333.isHidden = true
        fourC444.isHidden = true
        fourC555.isHidden = true
        fourC666.isHidden = true
        
        fourC1111.isHidden = true
        fourC2222.isHidden = true
        fourC3333.isHidden = true
        fourC4444.isHidden = true
        fourC5555.isHidden = true
        fourC6666.isHidden = true
        
        fourLabel1.text = ""
        fourLabel2.text = ""
        fourLabel3.text = ""
        fourLabel4.text = ""
        
        
        
        letter1.text = ""
        letter2.text = ""
        letter3.text = ""
        letter4.text = ""
        letter5.text = ""
        
        cr1.isHidden = true
        cr2.isHidden = true
        cr3.isHidden = true
        cr4.isHidden = true
        cr5.isHidden = true
        cr6.isHidden = true
        
        cr11.isHidden = true
        cr22.isHidden = true
        cr33.isHidden = true
        cr44.isHidden = true
        cr55.isHidden = true
        cr66.isHidden = true
        
        cr111.isHidden = true
        cr222.isHidden = true
        cr333.isHidden = true
        cr444.isHidden = true
        cr555.isHidden = true
        cr666.isHidden = true
        
        cr1111.isHidden = true
        cr2222.isHidden = true
        cr3333.isHidden = true
        cr4444.isHidden = true
        cr5555.isHidden = true
        cr6666.isHidden = true
        
        cr11111.isHidden = true
        cr22222.isHidden = true
        cr33333.isHidden = true
        cr44444.isHidden = true
        cr55555.isHidden = true
        cr66666.isHidden = true
        
        block1.isHidden = true
        block2.isHidden = true
        block3.isHidden = true
        block4.isHidden = true
        block5.isHidden = true
        
    }
    
    // add shadow to circle
    func addShadow(_ crl: UIButton){
        // reset circle
        crl.backgroundColor = UIColor(red:204/255, green:204/255, blue:204/255, alpha:1)
        crl.layer.borderWidth = 0
        
        crl.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        crl.layer.shadowOffset = CGSize(width: 1, height: 2)
        crl.layer.shadowOpacity = 2
        crl.layer.shadowRadius = 0.0
        crl.layer.masksToBounds = false
        crl.layer.cornerRadius = 0.5 * crl.bounds.size.width
    }
    
    // set braille for letter
    func setBraille(_ c1:UIButton,_ c2:UIButton, _ c3:UIButton, _ c4:UIButton, _ c5:UIButton, _ c6:UIButton,_ letter:String, _ label:UILabel,_ l:Character, block: UIView){
        
        c1.isHidden = false
        c2.isHidden = false
        c3.isHidden = false
        c4.isHidden = false
        c5.isHidden = false
        c6.isHidden = false
        block.isHidden = false
        
        label.text = "\(l)"
        for (i,s) in letter.enumerated() {
            
            if(s=="1"){
                if(i==0){
                    c1.backgroundColor = UIColor(named: "Color1")
                    c1.layer.borderWidth = 4
                    c1.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==1){
                    c2.backgroundColor = UIColor(named: "Color1")
                    c2.layer.borderWidth = 4
                    c2.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==2){
                    c3.backgroundColor = UIColor(named: "Color1")
                    c3.layer.borderWidth = 4
                    c3.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==3){
                    c4.backgroundColor = UIColor(named: "Color1")
                    c4.layer.borderWidth = 4
                    c4.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==4){
                    c5.backgroundColor = UIColor(named: "Color1")
                    c5.layer.borderWidth = 4
                    c5.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                else{
                    c6.backgroundColor = UIColor(named: "Color1")
                    c6.layer.borderWidth = 4
                    c6.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
            }
        }
    }
    
}






