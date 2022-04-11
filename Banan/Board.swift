//
//  Board.swift
//  Banan
//
//  Created by Noura  on 07/09/1443 AH.
//

import Foundation
import SwiftUI

struct Board: Identifiable {
    enum BoardEvaluation {
        case outStanding
        case excellent
        case good
        case tryAgain
    }
    var id = UUID()
    var level: String
    var point: Int
    var levels = [String]()
    var points = [String]()
    var eval: BoardEvaluation
    
    //get child object
    func getChild(){
        let child = LocalStorage.childValue
        if child != nil{
            gameInfo(child: child!)
        }
    }
    
    //child game info
    func gameInfo(child: Child){
        
       // let levels = child.GameLevels.map
    }
    
    func getEvaluationInfo() -> String {
        var img = ""
        
        switch eval {
            
        case .outStanding:
            img = "Outstanding"
        case .excellent:
            img = "Excellent"
        case .good:
            img = "Good"
        case .tryAgain:
            img = "TryAgain"
        }
        
        return img
    }
}

extension Board {
    // Dummy Data
    static func dummyData() -> [Board] {
        // array of board
        
        return [Board(level: "المستوى الأول", point: 70, eval: .outStanding),
                Board(level: "المستوى الثاني", point: 50, eval: .good),
                Board(level: "المستوى الثالث", point: 90, eval: .tryAgain)]
    }
}
