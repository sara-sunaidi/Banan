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
    var first = [[String : Any]]()
    var second = [[String : Any]]()
    var category : String = ""
    var arabicCategory : String = ""

    var num : Int = 0
    
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
    
    let foods = ["موز", "ليمون", "تفاح" ,"كمثرى" ,"بطيخ" ,"جزر" ,"عنب" ,"خوخ" ,"طماطم"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Category.text = arabicCategory
        
        addShadow(button: button1)
        addShadow(button: button2)
        addShadow(button: button3)
        addShadow(button: button4)
        addShadow(button: button5)
        addShadow(button: button6)
        addShadow(button: button7)
        addShadow(button: button8)
        addShadow(button: button9)

        database.collection("Words").whereField("Category", isEqualTo: category).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for i in querySnapshot!.documentChanges {
                    let docid = i.document.documentID
                    let word = i.document.get("Arabic")
                   // let letters = i.document.get("AllLetters")
                    
                    self.addImageToUIImageView(docid: docid,word: word as! String)

                }
                //print(querySnapshot ?? "nooooooo")
               // self.groupByLevel(dbSnapshot: querySnapshot)
                }
    //
        }
        
        //firebase.firestore().enablePersistence()
//        let docRef = database.collection("Words").document("Foods")
//        docRef.getDocument { (querySnapshot, error) in
//            if let document = querySnapshot, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//                //self.groupByLevel(dbSnapshot: querySnapshot)
////                for doc in querySnapshot!.documentID {
////                    self.allWords.append(doc)
////                }
//            } else {
//                print("Document does not exist")
//            }
//        }
//        database.collection("Words").document("Foods").getDocument { (querySnapshot, err) in
//            if let err = err {
//                print("الاوللError getting documents: \(err)")
//            } else {
//                //self.groupByLevel(dbSnapshot: querySnapshot)
//                print(querySnapshot ?? "الثانيhhhhhh")
//                }
////
//        }
      //  addImageToUIImageView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func groupByLevel(dbSnapshot: QuerySnapshot?) {
            print("heeeenaaaaa\(dbSnapshot!.documents.count)")
            
            for document in dbSnapshot!.documents {
                var dat = document.data()
               // dat["Letters"] = document.value(forKey: "AllLetters")
                //dat["Word"] = document.value(forKey: "Arabic")
                dat["gg"] = document.documentID

                dat["Image"] = UIImage (named: document.documentID)
                
                self.allWords.append(dat)
                
            }
        
        
        //...
        }
//    func groupByLevel(dbSnapshot: QuerySnapshot?) {
//            print(dbSnapshot!.documents.count)
//
//            for document in dbSnapshot!.documents {
//                var dat = document.data()
//                dat["food1"] = document.documentID
//                dat["food2"] = document.documentID
//
//               // self.allWords.append(dat)
//
//            }
        
       //first=allWords.filter({$0["Level"] as! String == "First"})
//        second = allLetters.filter({$0["Level"] as! String == "Second"})
        //...
        

    func addImageToUIImageView(docid: String, word: String){
        num+=1
        let yourImage: UIImage = UIImage(named: docid)!
       // print(allWords[0])
        getImg().image = yourImage
        getLabel().text = word
        
    }
    
    func getImg() -> UIImageView{
        switch(num){
        case 1: return img1
        case 2: return img2
        case 3: return img3
        case 4: return img4
        case 5: return img5
        case 6: return img6
        case 7: return img7
        case 8: return img8
        case 9: return img9
        default: return img1

        }
        
    }
    func getLabel() -> UILabel{
        switch(num){
        case 1: return word1
        case 2: return word2
        case 3: return word3
        case 4: return word4
        case 5: return word5
        case 6: return word6
        case 7: return word7
        case 8: return word8
        case 9: return word9
        default: return word1

        }
        
    }
    
    func addShadow(button : UIButton){
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
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
