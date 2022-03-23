//
//  WordViewController.swift
//  Banan
//
//  Created by Madawi Ahmed
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
    
    @IBOutlet weak var speakerBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    
    var newImage: UIImage!
    
//    @IBOutlet weak var tempImgView: UIImageView!
    
    override func viewDidLoad() {
        
        print("## in view load WORD")
        super.viewDidLoad()
        
        
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
    
}






