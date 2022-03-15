//
//  LearWordsViewController.swift
//  Banan
//
//  Created by Reema khalaf on 06/08/1443 AH.
//

import UIKit
import FirebaseFirestore
import Firebase
class LearWordsViewController: UIViewController {

    let database = Firestore.firestore()
    var allWords = [[String : Any]]()
    
    var Category : String = ""
    var arabicCategory : String = ""

    @IBOutlet weak var material: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var animal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow(button: material)
        addShadow(button: food)
        addShadow(button: place)
        addShadow(button: animal)

        database.collection("Words").whereField("Category", isEqualTo: "Food").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.groupByLevel(dbSnapshot: querySnapshot)
        // Do any additional setup after loading the view.
    }
        }
     
    }
    func groupByLevel(dbSnapshot: QuerySnapshot?) {
            print("heeeenaaaaa\(dbSnapshot!.documents.count)")

            for document in dbSnapshot!.documents {
                var dat = document.data()
                //dat["Letters"] = document.value(forKey: "AllLetters")
               // dat["Word"] = document.value(forKey: "Arabic")
               // dat["gg"] = document.documentID
                dat["Image"] = UIImage (named: document.documentID)

                self.allWords.append(dat)
                
//                print(allWords[0])

            }
        print(allWords[0])

        //print(allWords[0])
    }
    
    
    
    @IBAction func materialButton(_ sender: UIButton) {
        Category = "Material"
        arabicCategory = "أدوات"
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    @IBAction func foodButton(_ sender: UIButton) {
        Category = "Food"
        arabicCategory = "أطعمة"
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    @IBAction func placeButton(_ sender: UIButton) {
        Category = "Place"
        arabicCategory = "أماكن"
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    @IBAction func animalButton(_ sender: UIButton) {
        Category = "Animal"
        arabicCategory = "حيوانات"
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    
    func addShadow(button : UIButton){
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToWords" {
            let destinationVC = segue.destination as? WordsViewController
            destinationVC?.category = Category
            destinationVC?.arabicCategory = arabicCategory
            destinationVC?.allWords = allWords

            }
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
