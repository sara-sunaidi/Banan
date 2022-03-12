//
//  LettersViewController.swift
//  Banan
//
//  Created by Sara Alsunaidi on 12/03/2022.
//

import UIKit

class LettersViewController: UIViewController {

    var letters : [[String: Any]]?
    var completedLetters: [String]?
    
    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var letterOne: UIButton!
    @IBOutlet weak var letterTwo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        assignLettersImage(btn: letterOne, index: 0,title:  "المستوى الأول")
        assignLettersImage(btn: letterTwo, index: 1, title: "المستوى الثاني")
        //...
        
    }
    func assignLettersImage( btn: UIButton, index: Int, title: String){
        
        btn.setBackgroundImage( letters![index]["Image"] as! UIImage, for: .normal)
        btn.layer.cornerRadius = 30
        btn.layoutIfNeeded()
        btn.subviews.first?.contentMode = .scaleAspectFit
        
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        btn.layer.shadowOpacity = 0.8
        btn.layer.shadowRadius = 0.0
        btn.layer.masksToBounds = false
        
        levelName.text = title
        
        
        if(completedLetters!.contains(letters![index]["Letter"] as! String)){
            btn.backgroundColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }
    }
    
    @IBAction func pressBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
