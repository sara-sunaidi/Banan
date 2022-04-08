//
//  LevelsExtention.swift
//  Banan
//
//  Created by Sara Alsunaidi on 04/04/2022.
//

import Foundation

class ConvertLevel{
    static var levelArray = ["First",
                          "Second",
                          "Third",
                          "Fourth",
                          "Fifth",
                          "Sixth",
                          "Seventh",
                          "Eighth",
                          "Ninth",
                          "Tenth"
    ]
    
    static var levelTitleArray = ["المستوى الأول",
                          "المستوى الثاني",
                          "المستوى الثالث",
                          "المستوى الرابع",
                          "المستوى الخامس",
                          "المستوى السادس",
                          "المستوى السابع",
                          "المستوى الثامن",
                          "المستوى التاسع",
                          "المستوى العاشر"
    ]
    
     static func FindNextLevel( levelName: String)-> String{
         var index = ConvertLevel.levelArray.firstIndex(where: {$0 == levelName}) ?? 0
        index = index + 1
        
         return ConvertLevel.levelArray[index]
    }
    
    static func FindLevelTitle( levelName: String)-> String{
        var index = ConvertLevel.levelArray.firstIndex(where: {$0 == levelName}) ?? 0       
        return ConvertLevel.levelTitleArray[index]
   }
    static func findIndex(Level: String) -> Int{
        //error if not found
        return ConvertLevel.levelArray.firstIndex(where: {$0 == Level}) ?? 0
    }
    static func isLastLevel(availableLvels: [String], currentLevel: String) -> Bool{
        
        let currentIndex = findIndex(Level: currentLevel)
        for oneLevel in availableLvels{
            if currentIndex < findIndex(Level: oneLevel){
                return false
            }
        }
        return true
    }
}
