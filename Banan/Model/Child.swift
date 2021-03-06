//
//  Child.swift
//  Banan
//
//  Created by Sara Alsunaidi on 17/03/2022.
//

import Foundation

struct Child: Codable {
    var DOB :String = ""
    var completedLetters = [String]()
    var completedWords = [String]()
    
    var completedLevels = [String]()
    var completedCategories = [String]()

    var GameLevels = [[String: String]]()
    
    var email :String = ""
    var name :String = ""
    var gender :String = ""
}
