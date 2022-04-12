import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift


class FirebaseRequest{
    
    //Firestore Database
    static let db = Firestore.firestore()
    
    //Get user uniqe id
    static func getUserId() -> String? {
        
        let userID = Auth.auth().currentUser?.uid
        return userID
    }
    
    // Listen to Real Time update
    static func setDBListener(completion:@escaping(_ data: Any?, _ err:Error?) -> Void)  {
        //Set Listner
        db.collection("Children").document(getUserId()!)
            .addSnapshotListener { documentSnapshot, error in
                //                print("Exceution!!")
                
                guard let document = documentSnapshot else {
                    //Error
                    print("Error fetching document: \(error!)")
                    completion(nil,error)
                    //                    print("Not!!")
                    return
                }
                guard let data = document.data() else {
                    //                    print("Nottt!!")
                    return
                }
                //                print("SUCESS!!")
                
                //Featch changers successfully
                //                print("data in seeting db listener")
                completion(data,nil)
            }
    }
    
    //listen to database updates for letters and words
    static func setDBListenerLetters(completion:@escaping(_ data: Any?, _ err:Error?) -> Void){
        
        db.collection("Letters").addSnapshotListener{ (documentSnapshot, error) in
            
            guard let document = documentSnapshot else {
                //Error
                print("Error fetching document: \(error!)")
                completion(nil,error)
                print("Not!!")
                return
            }
            var allLetters = [Letters]()
            
            for document in documentSnapshot!.documents {
                var dat = document.data()
                dat["Letter"] = document.documentID
                dat["imageName"] = "\(document.documentID)Pic.png"
                
                allLetters.append(Letters(Arabic: dat["Arabic"] as! String,
                                          Braille: dat["Braille"] as! String,
                                          Letter: dat["Letter"] as! String,
                                          Level: dat["Level"] as! String,
                                          imageName: dat["imageName"] as! String))
                
            }
            //            print("SUCESSLetter!!")
            
            //Featch changers successfully
            //            print("data in seeting db listener")
            completion(allLetters,nil)
        }
        
        //
    }
    
    //listen to database updates for letters and words
    static func setDBListenerWords(completion:@escaping(_ data: Any?, _ err:Error?) -> Void){
        
        db.collection("Words").addSnapshotListener{ (documentSnapshot, error) in
            
            guard let document = documentSnapshot else {
                //Error
                print("Error fetching document: \(error!)")
                completion(nil,error)
                //                print("Not!!")
                return
            }
            var allWords = [Words]()
            
            for document in documentSnapshot!.documents {
                var dat = document.data()
                dat["Word"] = document.documentID
                dat["imageName"] = "\(document.documentID)"
                
                allWords.append(Words(AllLetters: dat["AllLetters"] as! [String],
                                      Arabic: dat["Arabic"] as! String,
                                      Category: dat["Category"] as! String,
                                      Word: dat["Word"] as! String,
                                      imageName: dat["imageName"] as! String
                                     ))
                
            }
            //            print("SUCESSLetter!!")
            
            //Featch changers successfully
            //            print("data in seeting db listener")
            completion(allWords,nil)
        }
        
        //
    }
    
    //fetch game
     static func setDBListenerGame(completion:@escaping(_ data: Any?, _ err:Error?) -> Void){
         
         db.collection("GameAnimals").addSnapshotListener{ (documentSnapshot, error) in
             
             guard let document = documentSnapshot else {
                 //Error
                 print("Error fetching document: \(error!)")
                 completion(nil,error)
 //                print("Not!!")
                 return
             }
             var allGameAnimal = [Game]()
             
             for document in documentSnapshot!.documents {
                 var dat = document.data()
                 dat["Animal"] = document.documentID
 //                dat["imageName"] = "\(document.documentID)"
                 allGameAnimal.append(Game(AllLetters: dat["AllLetters"] as! [String],
                                       Arabic: dat["Arabic"] as! String,
                                       Level: dat["Level"] as! String,
                                           Points: dat["Points"] as! String ,
                                           Animal: dat["Animal"] as! String
 //                                      imageName: dat["imageName"] as! String
                                      ))
                 
             }
 //            print("SUCESSLetter!!")
             
             //Featch changers successfully
 //            print("data in seeting db listener")
             completion(allGameAnimal,nil)
         }
     }
    
    static func addGameLevels(levelName : String, score: Float, userPoints: Int, eval: String){
        //        print("hhhhhhhhhhhhhhhhhhhhhhhhhh")
        //        var anim = animal.Animal
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = FirebaseRequest.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            //new level
            thisUserDoc.updateData([
                "GameLevels": FieldValue.arrayUnion([["Level" : levelName,
                                                      "Score": String(score),
                                                      "UserPoints": String(userPoints),
                                                      "Evaluation": eval
                                                     ]])
            ])
        }
    }
    
    static func updateGameLevels(levelName : String, score: Float, userPoints: Int, eval: String, oldData:[String:String]){
        //        var anim = animal.Animal
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = self.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            
            
            //remove old
            thisUserDoc.updateData([
                "GameLevels": FieldValue.arrayRemove([["Level" : oldData["Level"],
                                                       "Score": oldData["Score"],
                                                       "UserPoints": oldData["UserPoints"],
                                                       "Evaluation": oldData["Evaluation"]
                                                      ]])
            ])
            //new level
            thisUserDoc.updateData([
                "GameLevels": FieldValue.arrayUnion([["Level" : levelName,
                                                      "Score": String(score),
                                                      "UserPoints": String(userPoints),
                                                      "Evaluation": eval
                                                     ]])
            ])
        }
    }
}
