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

// Protocol in UIView Class for navigation purposes
protocol WordViewControllerDelegate {
    func didCheck()
}

var wordVC = WordViewController()

class WordViewController: UIViewController, UINavigationControllerDelegate, CustomAlertViewControllerDelegate, CustomConfirmationViewControllerDelegate {
    
    static let instance = WordViewController()
    
    var delegate: WordViewControllerDelegate?
    
    var allWords : [Words]?
    var index: Int?
    var allLetters: [Letters]?
    var wordBraille = [String]()
    
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
    
    
    var newImage: UIImage!
    
//    @IBOutlet weak var tempImgView: UIImageView!
    
    override func viewDidLoad() {
        
        print("## in view load WORD")
        super.viewDidLoad()
        
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
        
        
//        addColor("101100")
//        addColor("010111")
//        addColor("101011")
        CustomAlertViewController.instance.delegate = self
        CustomConfirmationViewController.instance.delegate = self
        if(newImage == nil){
            print("### Nil")
        }else{
            print("### NOT Nil")
            //            imageView.image = newImage
            
        }
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("image"), object: nil)
        
        // start session
        
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
        let image = notification.object as! UIImage?
//        tempImgView.image = image
    }
    
    
    @IBAction func checkAnswerBtn(_ sender: Any) {
        // # check answer method call
        print("## in Check")
        takePhotoVC.checkCameraPermissions()
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            takePhotoVC.didTapCheck()
        }
        //         Timer.scheduledTimer(timeInterval: 1.0,
        //                                             target: takePhotoVC.checkCameraPermissions(),
        //                             selector: #selector(checkAnswer),
        //                                             userInfo: nil,
        //                                             repeats: false)
        //        takePhotoVC.checkCameraPermissions()
        
        
        //        delegate?.didCheck()
        //        TakePhotoController.instance.takePhoto()
        //        checkAnswer()
        
        
    }
    
    //    func setImage (_ i:UIImage){
    //        self.imageView.image = i
    //
    //    }
    
    @objc private func checkAnswer(){
        print("## in CheckAnswer")
        takePhotoVC.didTapCheck()
        //        delegate?.didCheck()
        //        let image = TakePhotoController.instance.processAnswer()
        //        TakePhotoController.instance.processAnswer()
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let takePhotoVC = storyboard.instantiateViewController(withIdentifier: "TakePhotoController") as! TakePhotoController
        //        takePhotoVC.loadViewIfNeeded()
        //
        //        print("##### the result \(takePhotoVC.isViewLoaded)")
        
        // call processvc
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateViewController(identifier: "TakePhotoController" )as! TakePhotoController
        //        //               vc.source_image = image
        //        vc.modalPresentationStyle = .overFullScreen
        //        present(vc, animated:  true)
        //
        // WE NEED TO START SESSION AGAIN
        
        // call alert dialog
        //        CustomAlertViewController.instance.showAlert(title: "أحسنت !", message: "لقد أجبت إجابة صحيحة", alertType: .word)
    }
    
    @IBAction func onClickPreWord(_ sender: Any) {
        // # navigate to pre word
        // call alert dialog
        CustomAlertViewController.instance.showAlert(title: "ممتاز", message: "لقد أجبت إجابة صحيحة", alertType: .letter)
    }
    @IBAction func onClickExit(_ sender: Any) {
        print("### in original exit btn")
        //        self.dismiss(animated: true, completion: nil)
        //        performSegue(withIdentifier: "ToWord", sender: self)
        CustomConfirmationViewController.instance.showAlert(title: "تنبيه", message: "هل تود الخروج من الكلمة الحالية؟")
    }
    @IBAction func onClickSpeaker(_ sender: Any) {
        // # play audio
        CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "اختبار للاكنولجمنت النيقاتيف", acknowledgementType: .negative)
    }
    
    @IBAction func onClickGuide(_ sender: Any) {
        // # will be implemented in Group3
        
        //        CustomAcknowledgementViewController.instance.showAlert(title: "تنبيه", message: "اختبار للاكنولجمنت البوستف", acknowledgementType: .positive)
        
        // Snackbar calling is here
        let viewModel: SnackbarViewModel
        
        viewModel = SnackbarViewModel(text: "إجابة خاطئة..حاول مرة أخرى!", image: UIImage(named: "wrongAnswer"))
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 100)
        let snackbar = SnackbarView(viewModel: viewModel, frame: frame)
        showSnackbar(snackbar: snackbar)
    }
    
    
    
    // The coming three methods to handle correct answer pop-up actions
    
    func didContinueButtonTapped() {
        print("Continue tapped in word controller")
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
        
        // # update the completed words list
    }
    func didRedoButtonTapped() {
        print("Redo tapped in word controller")
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
        
        // # display the letter page again with the same index
    }
    func didExitButtonTapped() {
        print("Exit tapped in word controller")
        //        performSegue(withIdentifier: "ToStart", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    // The coming method to handle exit confirmation pop-up actions
    
    func didYesButtonTapped() {
        print("Yes tapped in word controller")
        self.dismiss(animated: true, completion: nil)
    }
    
    public func showSnackbar(snackbar: SnackbarView){
        
        let width = view.frame.size.width/1.5
        
        // set frame to start position
        snackbar.frame = CGRect(
            x: (view.frame.size.width-width)/2,
            y: view.frame.size.height,
            width: width,
            height: 140)
        
        view.addSubview(snackbar)
        
        // animate it upwards
        UIView.animate(withDuration: 0.5, animations: {
            snackbar.frame = CGRect(
                x: (self.view.frame.size.width-width)/2,
                y: self.view.frame.size.height - 150,
                width: width,
                height: 140)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    
                    // animate it downwards
                    UIView.animate(withDuration: 0.5, animations: {
                        snackbar.frame = CGRect(
                            x: (self.view.frame.size.width-width)/2,
                            y: self.view.frame.size.height,
                            width: width,
                            height: 140)
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
        let wordArabic = allWords![index!].Arabic
        var wordArray = Array(wordArabic)
        if(num == 3){
            
            setBraille(cr11,cr22,cr33,cr44,cr55,cr66,wordBraille[0],letter2,wordArray[0])
            setBraille(cr111,cr222,cr333,cr444,cr555,cr666,wordBraille[1],letter3,wordArray[1])
            setBraille(cr1111,cr2222,cr3333,cr4444,cr5555,cr6666,wordBraille[2],letter4,wordArray[2])
        }
        else if(num == 4){
            
            setBraille(cr11,cr22,cr33,cr44,cr55,cr66,wordBraille[0],letter2,wordArray[0])
            setBraille(cr111,cr222,cr333,cr444,cr555,cr666,wordBraille[1],letter3,wordArray[1])
            setBraille(cr1111,cr2222,cr3333,cr4444,cr5555,cr6666,wordBraille[2],letter4,wordArray[2])
            setBraille(cr11111,cr22222,cr33333,cr44444,cr55555,cr66666,wordBraille[3],letter5,wordArray[3])
        }
        else{
            
            setBraille(cr1,cr2,cr3,cr4,cr5,cr6,wordBraille[0],letter1,wordArray[0])
            setBraille(cr11,cr22,cr33,cr44,cr55,cr66,wordBraille[0],letter2,wordArray[1])
            setBraille(cr111,cr222,cr333,cr444,cr555,cr666,wordBraille[1],letter3,wordArray[2])
            setBraille(cr1111,cr2222,cr3333,cr4444,cr5555,cr6666,wordBraille[2],letter4,wordArray[3])
            setBraille(cr11111,cr22222,cr33333,cr44444,cr55555,cr66666,wordBraille[3],letter5,wordArray[4])
        }
        
    }
    
    // hide circle
    func hideCircle(){
        
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
    
    // add color to circle
    func addColor(_ st: String){
        for (i,s) in st.enumerated() {
            
            if(s=="1"){
                if(i==0){
                    cr1.backgroundColor = UIColor(named: "Color1")
                    cr1.layer.borderWidth = 4
                    cr1.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr11.backgroundColor = UIColor(named: "Color1")
                    cr11.layer.borderWidth = 4
                    cr11.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr111.backgroundColor = UIColor(named: "Color1")
                    cr111.layer.borderWidth = 4
                    cr111.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr1111.backgroundColor = UIColor(named: "Color1")
                    cr1111.layer.borderWidth = 4
                    cr1111.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr11111.backgroundColor = UIColor(named: "Color1")
                    cr11111.layer.borderWidth = 4
                    cr11111.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==1){
                    cr2.backgroundColor = UIColor(named: "Color1")
                    cr2.layer.borderWidth = 4
                    cr2.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr22.backgroundColor = UIColor(named: "Color1")
                    cr22.layer.borderWidth = 4
                    cr22.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr222.backgroundColor = UIColor(named: "Color1")
                    cr222.layer.borderWidth = 4
                    cr222.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr2222.backgroundColor = UIColor(named: "Color1")
                    cr2222.layer.borderWidth = 4
                    cr2222.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr22222.backgroundColor = UIColor(named: "Color1")
                    cr22222.layer.borderWidth = 4
                    cr22222.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==2){
                  cr3.backgroundColor = UIColor(named: "Color1")
                    cr3.layer.borderWidth = 4
                    cr3.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr33.backgroundColor = UIColor(named: "Color1")
                      cr33.layer.borderWidth = 4
                      cr33.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr333.backgroundColor = UIColor(named: "Color1")
                      cr333.layer.borderWidth = 4
                      cr333.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr3333.backgroundColor = UIColor(named: "Color1")
                      cr3333.layer.borderWidth = 4
                      cr3333.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr33333.backgroundColor = UIColor(named: "Color1")
                      cr33333.layer.borderWidth = 4
                      cr33333.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==3){
                    cr4.backgroundColor = UIColor(named: "Color1")
                    cr4.layer.borderWidth = 4
                    cr4.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr44.backgroundColor = UIColor(named: "Color1")
                    cr44.layer.borderWidth = 4
                    cr44.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr444.backgroundColor = UIColor(named: "Color1")
                    cr444.layer.borderWidth = 4
                    cr444.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr4444.backgroundColor = UIColor(named: "Color1")
                    cr4444.layer.borderWidth = 4
                    cr4444.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr44444.backgroundColor = UIColor(named: "Color1")
                    cr44444.layer.borderWidth = 4
                    cr44444.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
                
                else if(i==4){
                    cr5.backgroundColor = UIColor(named: "Color1")
                    cr5.layer.borderWidth = 4
                    cr5.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr55.backgroundColor = UIColor(named: "Color1")
                    cr55.layer.borderWidth = 4
                    cr55.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr555.backgroundColor = UIColor(named: "Color1")
                    cr555.layer.borderWidth = 4
                    cr555.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr5555.backgroundColor = UIColor(named: "Color1")
                    cr5555.layer.borderWidth = 4
                    cr5555.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr55555.backgroundColor = UIColor(named: "Color1")
                    cr55555.layer.borderWidth = 4
                    cr55555.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    
                }
                else{
                    cr6.backgroundColor = UIColor(named: "Color1")
                    cr6.layer.borderWidth = 4
                    cr6.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr66.backgroundColor = UIColor(named: "Color1")
                    cr66.layer.borderWidth = 4
                    cr66.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr666.backgroundColor = UIColor(named: "Color1")
                    cr666.layer.borderWidth = 4
                    cr666.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr6666.backgroundColor = UIColor(named: "Color1")
                    cr6666.layer.borderWidth = 4
                    cr6666.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                    cr66666.backgroundColor = UIColor(named: "Color1")
                    cr66666.layer.borderWidth = 4
                    cr66666.layer.borderColor = UIColor(red:145/255, green:203/255, blue:191/255, alpha:1).cgColor
                }
            }
        }
    }
    
    // set braille for letter
    func setBraille(_ c1:UIButton,_ c2:UIButton, _ c3:UIButton, _ c4:UIButton, _ c5:UIButton, _ c6:UIButton,_ letter:String, _ label:UILabel,_ l:Character){
        
        c1.isHidden = false
        c2.isHidden = false
        c3.isHidden = false
        c4.isHidden = false
        c5.isHidden = false
        c6.isHidden = false
        
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






