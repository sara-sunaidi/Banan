//
//  LettersViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 12/03/2022.
//

import UIKit

class Letters2ViewController: UIViewController {

    var letters : [Letters]?
    var completedLetters: [String]?
    var levelTitle: String?
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var letterOne: UIButton!
    @IBOutlet weak var letterTwo: UIButton!
    var index = 0
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidAppear(_ animated: Bool) {

        if(appdelegate.isChild){
            getChildData()}
        assignLettersImage(btn: letterOne, index: 0)
        assignLettersImage(btn: letterTwo, index: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                
        levelName.text = levelTitle
        if(appdelegate.isChild){
            getChildData()}
        
        assignLettersImage(btn: letterOne, index: 0)
        assignLettersImage(btn: letterTwo, index: 1)
        
        
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
    func assignLettersImage( btn: UIButton, index: Int){
        let image = UIImage(named: "\(letters![index].Letter)Pic.png")
        //or
        // let image = UIImage(named: "\(letters![index].imageName)")
        btn.setBackgroundImage( image, for: .normal)
        btn.layer.cornerRadius = 30
        btn.layoutIfNeeded()
        btn.subviews.first?.contentMode = .scaleAspectFit
        
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btn.layer.shadowOpacity = 0.8
        btn.layer.shadowRadius = 0.0
        btn.layer.masksToBounds = false
        
        
        if(appdelegate.isChild){
        
        if(completedLetters!.contains(letters![index].Letter )){
            btn.backgroundColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)}
        }
        }
    
    @IBAction func pressBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func selectLetter(_ sender: UIButton) {
         index = 0
        
        switch sender{
        case letterOne:
            index =  0
            break;
            
        case letterTwo:
            index =  1
            break;
        //...
        default:
            print("select another btn letter")
        }
        
        //send to noura's page
        performSegue(withIdentifier: "GoToLearnLetter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToLearnLetter"{
            let destination = segue.destination as! LearnLetterViewController
            destination.letters = letters
            destination.index = index
        }
    }

    
}
