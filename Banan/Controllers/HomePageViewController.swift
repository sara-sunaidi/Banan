//
//  HomePageViewController.swift
//  Banan
//
//  Created by Reema khalaf on 28/07/1443 AH.
//

import UIKit
import SwiftUI
import FirebaseFirestore
import Firebase

class HomePageViewController : UIViewController{
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var points: UILabel!
    var Profile : String = ""
    var Score : String = ""
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

   
    
        if let userId = Auth.auth().currentUser?.uid {
                let collectionRef = self.db.collection("Children")
                let thisUserDoc = collectionRef.document(userId)
                thisUserDoc.getDocument(completion: { document, error in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    if let doc = document {
                        self.name.text =  doc.get("Name") as? String
                        self.points.text = doc.get("Score") as? String
                        let Profile = doc.get("Gender") as? String
                        if Profile == "Boy"{
                            self.profileImage.configuration? .background.image = UIImage(named: "boy123.png")
                            //profileImage.setImage(UIImage(named: "boy123.png"), for: .normal)
                           // profileImage.image = UIImage(named: "boy123.png")
                        }
                        else {
                            self.profileImage.configuration? .background.image = UIImage(named: "girl123.png")
                            //profileImage.setImage(UIImage(named:"girl123.png"), for:.normal)
                            //profileImage.image = UIImage(named: "girl123.png")
                        }
                    }
                })
            }

//            if let userId = Auth.auth().currentUser?.uid {
//                print("gggggg")
//                print(userId)
//            var userName = db.collection("Children").getDocuments() { (snapshot, error) in
//                if let error = error {
//                    print("dddddddddd")
//            } else {
//                //do something
//                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
//                    let Name = currentUserDoc["Name"] as! String
//
//                }
//                        }
//                    }
//                }
            
//        var ref: DatabaseReference!
//
//        ref = Database.database().reference()
//        if let Uid = uid{
//            ref.child("Children").child(Uid).getData { error, <#DataSnapshot#> in
//                if error == nil{
//
//                }
//                <#code#>
//            }}
//        if let userId = uid {
//           let docRef = db.collection("Children").document(userId)}
//        print(docRef)
        
//        db.collection("Children").getDocuments { querySnapshot, error in
//            if let e = error{
//
//            }else{
//
//            }
//
//            <#code#>
//        }
       // name.text = Name
      
        // Do any additional setup after loading the view.
      
    }
    
    
    @IBAction func profilePressed(_ sender: UIButton) {
        //print("gggggg")
    }
    
    @IBAction func learnpressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goTolearn", sender: Self.self)
    }
    
}
