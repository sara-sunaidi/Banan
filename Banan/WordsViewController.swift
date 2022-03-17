//
//  WordsViewController.swift
//  Banan
//
//  Created by Reema khalaf on 07/08/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseCore
class WordsViewController: UIViewController {
    
    let database = Firestore.firestore()
    var allWords = [[String : Any]]()
    var completedWords = [String]()

    var category : String = ""
    var arabicCategory : String = ""
    
    var index : Int = 0
    
    @IBOutlet weak var Category: UILabel!
    
//buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
// image views
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var img8: UIImageView!
    @IBOutlet weak var img9: UIImageView!
//labels
    @IBOutlet weak var word1: UILabel!
    @IBOutlet weak var word2: UILabel!
    @IBOutlet weak var word3: UILabel!
    @IBOutlet weak var word4: UILabel!
    @IBOutlet weak var word5: UILabel!
    @IBOutlet weak var word6: UILabel!
    @IBOutlet weak var word7: UILabel!
    @IBOutlet weak var word8: UILabel!
    @IBOutlet weak var word9: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        button1.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button2.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button3.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button4.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button5.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button6.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button7.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button8.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        button9.tintColor =  UIColor(red: 237/255, green: 213/255, blue: 141/255, alpha: 1)
        
        Category.text = arabicCategory
        print("ooooooooooo")
        print(completedWords)
        print("ooooooooooo")

        designButton(button: button1, completed: completedWords.contains(allWords[0]["word"] as! String))
        designButton(button: button2, completed: completedWords.contains(allWords[1]["word"] as! String))
        designButton(button: button3, completed: completedWords.contains(allWords[2]["word"] as! String))
        designButton(button: button4, completed: completedWords.contains(allWords[3]["word"] as! String))
        designButton(button: button5, completed: completedWords.contains(allWords[4]["word"] as! String))
        designButton(button: button6, completed: completedWords.contains(allWords[5]["word"] as! String))
        designButton(button: button7, completed: completedWords.contains(allWords[6]["word"] as! String))
        designButton(button: button8, completed: completedWords.contains(allWords[7]["word"] as! String))
        designButton(button: button9, completed: completedWords.contains(allWords[8]["word"] as! String))
        
        addImageToUIImageView(index: 0, img: img1, label: word1)
        addImageToUIImageView(index: 1, img: img2, label: word2)
        addImageToUIImageView(index: 2, img: img3, label: word3)
        addImageToUIImageView(index: 3, img: img4, label: word4)
        addImageToUIImageView(index: 4, img: img5, label: word5)
        addImageToUIImageView(index: 5, img: img6, label: word6)
        addImageToUIImageView(index: 6, img: img7, label: word7)
        addImageToUIImageView(index: 7, img: img8, label: word8)
        addImageToUIImageView(index: 8, img: img9, label: word9)
        

    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
        

    func addImageToUIImageView(index: Int, img: UIImageView, label: UILabel){
        let yourImage: UIImage = UIImage(named: allWords[index]["word"] as! String)!
       // print(allWords[0])
        img.image = yourImage
        label.text = (allWords[index]["arabic"] as! String)
        
    }
    

    
    func designButton(button : UIButton, completed: Bool){
        if (completed){
            button.tintColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        index = 0
    }
    @IBAction func button2Pressed(_ sender: UIButton) {
        index = 1
    }
    @IBAction func button3Pressed(_ sender: UIButton) {
        index = 2
    }
    @IBAction func button4Pressed(_ sender: UIButton) {
        index = 3
    }
    @IBAction func button5Pressed(_ sender: UIButton) {
        index = 4
    }
    @IBAction func button6Pressed(_ sender: UIButton) {
        index = 5
    }
    @IBAction func button7Pressed(_ sender: UIButton) {
        index = 6
    }
    @IBAction func button8Pressed(_ sender: UIButton) {
        index = 7
    }
    @IBAction func button9Pressed(_ sender: UIButton) {
        index = 8
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
