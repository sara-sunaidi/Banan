//
//  Board.swift
//  Banan
//
//  Created by Madawi Ahmed on 04/09/1443 AH.
//

import Foundation
import SwiftUI

struct Board: Identifiable {
    
    // enum for different images
    enum BoardEvaluation {
        case outStanding
        case excellent
        case good
        case tryAgain
    }
    var id = UUID()
    var level: String
    var points: Int
    var eval: BoardEvaluation
    
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
        return [Board(level: "المستوى الأول", points: 70, eval: .outStanding),
                Board(level: "المستوى الثاني", points: 50, eval: .good),
                Board(level: "المستوى الثالث", points: 90, eval: .tryAgain)]
    }
}
