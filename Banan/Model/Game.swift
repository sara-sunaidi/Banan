//
//  Game.swift
//  Banan
//
//  Created by Noura  on 11/09/1443 AH.
//

import Foundation


struct Game: Codable {
    var AllLetters : [String]
    var Arabic :String = ""
    var Level :String = ""
    var Points: String = "0"
    var Animal: String = ""
    var currentPoint: Int = 0
//    var imageName: String = ""
    
    
    mutating func setCurrent(point: Int){
        currentPoint = point
    }
}
