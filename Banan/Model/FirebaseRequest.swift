//
//  FirebaseRequest.swift
//  Banan
//
//  Created by Sara Alsunaidi on 16/03/2022.
//

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
                
                allLetters.append(Letters(Arabic: dat["Arabic"] as? String ?? "",
                                          Braille: dat["Braille"] as? String ?? "",
                                          Letter: dat["Letter"] as? String ?? "",
                                          Level: dat["Level"] as? String ?? "",
                                          imageName: dat["imageName"] as? String ?? ""))
                
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
                
                allWords.append(Words(AllLetters: dat["AllLetters"] as? [String] ?? [""],
                                      Arabic: dat["Arabic"] as? String ?? "",
                                      Category: dat["Category"] as? String ?? "",
                                      Word: dat["Word"] as? String ?? "",
                                      imageName: dat["imageName"] as? String ?? ""
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
                allGameAnimal.append(Game(AllLetters: dat["AllLetters"] as? [String] ?? [""],
                                          Arabic: dat["Arabic"] as? String ?? "",
                                          Level: dat["Level"] as? String ?? "",
                                          Points: dat["Points"] as? String ?? "",
                                          Animal: dat["Animal"] as? String ?? ""
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
    
    static func updateCompletedLetter(letter: String, level: String){
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = self.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            thisUserDoc.updateData([
                "CompletedLetter": FieldValue.arrayUnion([letter])
            ])
        }
        updateCompletedLetterLevels(level: level)
        
    }
    
    static func updateCompletedWord(word: String){
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = self.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            thisUserDoc.updateData([
                "CompletedWord": FieldValue.arrayUnion([word])
            ])
        }
        //        print("-> The word is \(word)")
        updateCompletedCategories()
    }
    
    static func updateCompletedCategories() {
        
        var material = [String]()
        var food = [String]()
        var place = [String]()
        var animal = [String]()
        
        var updateMaterial = true
        var updateFood = true
        var updatePlace = true
        var updateAnimal = true
        
        var completedWords = [String]()
        
        // Step 1: get user completed words
        if let userId = Auth.auth().currentUser?.uid {
            let collectionRef = self.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            
            thisUserDoc.getDocument{ (document, error) in
                guard let document = document, document.exists else {
                    print("Document does not exist")
                    return
                }
                let dataDescription = document.data()
                completedWords = dataDescription?["CompletedWord"] as! [String]
                print(" Completed Words are -> \(completedWords)")
            }
            
            // Step 2: get words for each category and compare them to completedWordsSet to know if it needs to be updated
            
            // Material Category
            db.collection("Words").whereField("Category", isEqualTo: "Material").getDocuments(){(querySnapshor , err) in
                if let oErr = err {
                    print("Error: \(oErr.localizedDescription)")
                } else {
                    for document in querySnapshor!.documents
                    {
                        material.append(document.documentID)
                        
                        
                    }
                    //                print(" Material array is -> \(material)")
                    
                    
                    for element in material {
                        if(!completedWords.contains(element)){
                            updateMaterial = false
                        }
                    }
                    
                    print(" update material flag -> \(updateMaterial)")
                    
                    if (updateMaterial){
                        thisUserDoc.updateData([
                            "CompletedCategory": FieldValue.arrayUnion(["Material"])
                        ])
                    }
                    
                }
            }
            
            // Food Category
            db.collection("Words").whereField("Category", isEqualTo: "Food").getDocuments(){(querySnapshor , err) in
                if let oErr = err {
                    print("Error: \(oErr.localizedDescription)")
                } else {
                    for document in querySnapshor!.documents
                    {
                        food.append(document.documentID)
                        
                        
                    }
                    //                print(" Food array is -> \(food)")
                    
                    
                    for element in food {
                        if(!completedWords.contains(element)){
                            updateFood = false
                        }
                    }
                    
                    print(" update food flag -> \(updateFood)")
                    
                    if (updateFood){
                        thisUserDoc.updateData([
                            "CompletedCategory": FieldValue.arrayUnion(["Food"])
                        ])
                    }
                    
                }
            }
            
            // Place Category
            db.collection("Words").whereField("Category", isEqualTo: "Place").getDocuments(){(querySnapshor , err) in
                if let oErr = err {
                    print("Error: \(oErr.localizedDescription)")
                } else {
                    for document in querySnapshor!.documents
                    {
                        place.append(document.documentID)
                        
                        
                    }
                    //                print(" Place array is -> \(place)")
                    
                    
                    for element in place {
                        if(!completedWords.contains(element)){
                            updatePlace = false
                        }
                    }
                    
                    print(" update place flag -> \(updatePlace)")
                    
                    if (updatePlace){
                        thisUserDoc.updateData([
                            "CompletedCategory": FieldValue.arrayUnion(["Place"])
                        ])
                    }
                    
                }
            }
            
            // Animals Category
            db.collection("Words").whereField("Category", isEqualTo: "Animal").getDocuments(){(querySnapshor , err) in
                if let oErr = err {
                    print("Error: \(oErr.localizedDescription)")
                } else {
                    for document in querySnapshor!.documents
                    {
                        animal.append(document.documentID)
                        
                        
                    }
                    //                print(" Animal array is -> \(animal)")
                    
                    
                    for element in animal {
                        if(!completedWords.contains(element)){
                            updateAnimal = false
                        }
                    }
                    
                    print(" update animal flag -> \(updateAnimal)")
                    
                    if (updateAnimal){
                        thisUserDoc.updateData([
                            "CompletedCategory": FieldValue.arrayUnion(["Animal"])
                        ])
                    }
                    
                }
            }
            
        }
    }
   
    
    static func updateCompletedLetterLevels(level :String) {
        
//        var material = [String]()
//        var food = [String]()
//        var place = [String]()
//        var animal = [String]()
//
//        var updateMaterial = true
//        var updateFood = true
//        var updatePlace = true
//        var updateAnimal = true
        
        var completedLetters = [String]()
        var levelLetters = [String]()
        
        // Step 1: get user completed letters
        if let userId = getUserId() {
            let collectionRef = self.db.collection("Children")
            let thisUserDoc = collectionRef.document(userId)
            
            thisUserDoc.getDocument{ (document, error) in
                guard let document = document, document.exists else {
                    print("Document does not exist")
                    return
                }
                let dataDescription = document.data()
                completedLetters = dataDescription?["CompletedLetter"] as! [String]
                print(" Completed letters are -> \(completedLetters)")
            }
            
            // Step 2: get words for each category and compare them to completedWordsSet to know if it needs to be updated
            
            // Material Category
            db.collection("Letters").whereField("Level", isEqualTo: level).getDocuments(){(querySnapshor , err) in
                if let oErr = err {
                    print("Error: \(oErr.localizedDescription)")
                } else {
                    for document in querySnapshor!.documents
                    {
                        levelLetters.append(document.documentID)
                    }
                    
                    var intersect =  Set(levelLetters).intersection(completedLetters).count
                     
                     if( intersect == levelLetters.count){
                         //update completed level
                         thisUserDoc.updateData(["CompletedLevel": FieldValue.arrayUnion([level])])
                     }
                }
            }
            
        }
    }
}
