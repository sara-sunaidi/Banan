//
//  LearWordsViewController.swift
//  Banan
//
//  Created by Reema khalaf on 06/08/1443 AH.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
class LearWordsViewController: UIViewController {

    let database = Firestore.firestore()
    var allWords = [[String : Any]]()
    
    var allMaterial = [[String : Any]]()
    var allFood = [[String : Any]]()
    var allPlace = [[String : Any]]()
    var allAnimal = [[String : Any]]()

    var completedCategory = [String]()
    var completedWords = [String]()

    var Category : String = ""
    var arabicCategory : String = ""

    @IBOutlet weak var material: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var animal: UIButton!
    
    @IBOutlet weak var completedMaterial: UILabel!
    @IBOutlet weak var completedFood: UILabel!
    @IBOutlet weak var completedPlace: UILabel!
    @IBOutlet weak var completedAnimal: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = self.database.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            
            thisUserDoc.getDocument { (document, error ) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    
                    self.completedCategory = dataDescription?["CompletedCategory"] as! [String]
                    
                    self.completedWords = dataDescription?["CompletedWord"] as! [String]
                    
                } else {
                    print("doc does not exist")
                }
                
                self.database.collection("Words").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("error gitting document: \(err)")
                    } else {
                        self.groupByLevel(dbSnapshot: querySnapshot)
                        self.buttonCategory()
                    }
                    
                }
            }
        }
            
//        designButton(button: material, completed: completedCategory.contains("Material"))
//        designButton(button: food, completed: completedCategory.contains("Food"))
//        designButton(button: place, completed: completedCategory.contains("Place"))
//        designButton(button: animal, completed: completedCategory.contains("Animal"))

//        database.collection("Words").whereField("Category", isEqualTo: "Food").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                self.groupByLevel(dbSnapshot: querySnapshot)
//        // Do any additional setup after loading the view.
//    }
//       }
//
    }
//    func groupByLevel(dbSnapshot: QuerySnapshot?) {
//            print("heeeenaaaaa\(dbSnapshot!.documents.count)")
//
//            for document in dbSnapshot!.documents {
//                var dat = document.data()
//                //dat["Letters"] = document.value(forKey: "AllLetters")
//               // dat["Word"] = document.value(forKey: "Arabic")
//               // dat["gg"] = document.documentID
//                dat["Image"] = UIImage (named: document.documentID)
//
//                self.allWords.append(dat)
//
////                print(allWords[0])
//
//            }
//        print(allWords[0])
//
//        //print(allWords[0])
//    }
    func buttonCategory() {
        
        designButton(button: material, completed: completedCategory.contains("Material"), label: completedMaterial, catArray: allMaterial)
    designButton(button: food, completed: completedCategory.contains("Food"), label: completedFood, catArray: allFood)
    designButton(button: place, completed: completedCategory.contains("Place"), label: completedPlace, catArray: allPlace)
    designButton(button: animal, completed: completedCategory.contains("Animal"), label: completedAnimal, catArray: allAnimal)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func materialButton(_ sender: UIButton) {
//        Category = "Material"
//        arabicCategory = "أدوات"
//        allWords = allMaterial
//        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    @IBAction func foodButton(_ sender: UIButton) {
        Category = "Food"
        arabicCategory = "أطعمة"
        allWords = allFood
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    @IBAction func placeButton(_ sender: UIButton) {
//        Category = "Place"
//        arabicCategory = "أماكن"
//        allWords = allPlace
//        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    @IBAction func animalButton(_ sender: UIButton) {
        Category = "Animal"
        arabicCategory = "حيوانات"
        allWords = allAnimal
        performSegue(withIdentifier: "GoToWords", sender: self)
    }
    
    func designButton(button : UIButton, completed: Bool, label:UILabel, catArray: [[String : Any]]){
        let filteredArray = catArray.map{$0["word"]} as! [String]
        let intersect = Set(filteredArray).intersection(completedWords).count
  print("ooooooooooooo")
        print(filteredArray.count)
        print(intersect)
  print("ooooooooooooo")
        if (intersect != 0) {
        label.text = "\(filteredArray.count)/\(intersect) من الكلمات تم دراستها"
        }
        if (completed){
            button.tintColor = UIColor(red: 193/255, green: 222/255, blue: 183/255, alpha: 1)
        }
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
    }
    func groupByLevel(dbSnapshot: QuerySnapshot?) {
        print("grouping")
            print(dbSnapshot!.documents.count)
            
            for document in dbSnapshot!.documents {
                var dat = document.data()
                dat["catogory"] = document.get("Category")
                dat["word"] = document.documentID
                dat["arabic"] = document.get("Arabic")
                dat["allLetters"] = document.get("AllLetters")

                self.allWords.append(dat)
                
            }
        
        allMaterial = allWords.filter({$0["Category"] as! String == "Material"})
        allFood = allWords.filter({$0["Category"] as! String == "Food"})
        allPlace = allWords.filter({$0["Category"] as! String == "Place"})
        allAnimal = allWords.filter({$0["Category"] as! String == "Animal"})
        
print("end grouping")
        print(allFood)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToWords" {
            let destinationVC = segue.destination as? WordsViewController
            destinationVC?.category = Category
            destinationVC?.arabicCategory = arabicCategory
            destinationVC?.allWords = allWords
            destinationVC?.completedWords = completedWords


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
