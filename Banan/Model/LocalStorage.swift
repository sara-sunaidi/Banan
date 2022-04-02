//
//  LocalStorage.swift
//  Banan
//
//  Created by Sara Alsunaidi on 17/03/2022.
//

import Foundation


class LocalStorage{
    
    
    private static var childKey: String = "child"
    private static var LettersKey: String = "allLetters"
    private static var WordsKey: String = "allWords"
    private static var GameKey: String = "allGame"
    
    public static var childValue: Child? {
        set {
            
            let encoder = JSONEncoder()
            do{
                // Encode Child
                let data = try encoder.encode(newValue)
                //Set child
                UserDefaults.standard.set(data, forKey: childKey)
            }catch{
                print("UserDefaults error cannot set for child key", error.localizedDescription)
            }
            
        }
        
        get{
            if let data = UserDefaults.standard.data(forKey: childKey) {
                do{
                    //Decode Child
                    let decoder = JSONDecoder()
                    let child = try decoder.decode(Child.self, from: data)
                    return child
                }catch{
                    print("err get user")
                }
            }
            return nil
        }
        
    }
    
    public static var allLettersInfo: [Letters]? {
        set {
            
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: LettersKey)
                
            }catch{
                print("UserDefaults error cannot set for child key", error.localizedDescription)
            }
            
        }
        get{
            if let data = UserDefaults.standard.data(forKey: LettersKey){
                
                do{
                    let decoder = JSONDecoder()
                    let lett = try decoder.decode([Letters].self, from: data)
                    print(lett)
                    return lett
                }catch{
                    print("err get user")
                }
            }
            return nil
        }
        
    }
    
    public static var allWordsInfo: [Words]? {
        set {
            
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: WordsKey)
                
            }catch{
                print("UserDefaults error cannot set for child key", error.localizedDescription)
            }
            
        }
        get{
            if let data = UserDefaults.standard.data(forKey: WordsKey){
                
                do{
                    let decoder = JSONDecoder()
                    let word = try decoder.decode([Words].self, from: data)
                    print(word)
                    return word
                }catch{
                    print("err get user")
                }
            }
            return nil
        }
    }
    
    
    public static var allGameInfo: [Game]? {
        set {
            
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: GameKey)
                
            }catch{
                print("UserDefaults error cannot set for child key", error.localizedDescription)
            }
            
        }
        get{
            if let data = UserDefaults.standard.data(forKey: GameKey){

                do{
                    let decoder = JSONDecoder()
                    let game = try decoder.decode([Game].self, from: data)
                    print(game)
                    return game
                }catch{
                    print("err get user")
                }
        }
            return nil
    }
        
        
    }
    
    
    static func removeChild(){
        if checkExistChild() {
            UserDefaults.standard.removeObject(forKey: "child")
        }
        
    }
    
    static func checkExistChild() -> Bool{
        if (UserDefaults.standard.object(forKey: "child") != nil) {
            return true
        }
        return false
        
    }
    
}
