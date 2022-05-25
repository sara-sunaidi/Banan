//
//  Game.swift
//  Banan
//
//  Created by Sara Alsunaidi on 01/04/2022.
//
import Foundation


struct Game: Codable {
    var AllLetters : [String]
    var Arabic :String = ""
    var Level :String = ""
    var Points: String = "0"
    var Animal: String = ""
    var currentPoint: Int = 0
    
    
    mutating func setCurrent(point: Int){
        currentPoint = point
    }
}
