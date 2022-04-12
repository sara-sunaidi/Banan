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
    var eval: BoardEvaluation

    static var levels = [String?]()
    static var points = [String?]()
    static var evals = [String?]()
    
    //get child object
    mutating func getChild(){
        print("in booooaaardddd")
        let child = LocalStorage.childValue
        if child != nil{
            Board.levels = getGameLevels(child: child!)
            Board.points = getGamePoitns(child: child!)
            Board.evals = getGameEvals(child: child!)
        }
    }
    
    //get child completed levels
     func getGameLevels(child: Child) -> [String?]{
        
        let gameLevels = child.GameLevels.map({ $0["Level"] })
        print("game level \(gameLevels)")
        
  return gameLevels
    }
    
    //get child point of each level
    func getGamePoitns(child: Child) -> [String?]{
       
       let gamePoitns = child.GameLevels.map({ $0["Score"] })
       print("game point \(gamePoitns)")
        
 return gamePoitns
    }
    
    //get child eval of each level
    func getGameEvals(child: Child) -> [String?]{
       
       let gameEvals = child.GameLevels.map({ $0["Evaluation"] })
       print("game point \(gameEvals)")
        
 return gameEvals
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
        var boardArray = [Board]()
        var i = 0
        var j = 0

        for l in levels {
            if(l == "First"){
                if(evals[j] == "رائع"){
                    let b = Board(level: "المستوى الأول", point: Int(points[j]!)! , eval: .outStanding)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "ممتاز"){
                    let b = Board(level: "المستوى الأول", point: Int(points[j]!)! , eval: .excellent)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "جيد"){
                    let b = Board(level: "المستوى الأول", point: Int(points[j]!)! , eval: .good)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "حاول مرة أخرى"){
                    let b = Board(level: "المستوى الأول", point: Int(points[j]!)! , eval: .tryAgain)
                    boardArray[i] = b
                    i = i+1
                }
                }
            else if (l == "Second"){
                if(evals[j] == "رائع"){
                    let b = Board(level: "المستوى الثاني", point: Int(points[j]!)! , eval: .outStanding)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "ممتاز"){
                    let b = Board(level: "المستوى الثاني", point: Int(points[j]!)! , eval: .excellent)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "جيد"){
                    let b = Board(level: "المستوى الثاني", point: Int(points[j]!)! , eval: .good)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "حاول مرة أخرى"){
                    let b = Board(level: "المستوى الثاني", point: Int(points[j]!)! , eval: .tryAgain)
                    boardArray[i] = b
                    i = i+1
                }
                }
            else {
                if(evals[j] == "رائع"){
                    let b = Board(level: "المستوى الثالث", point: Int(points[j]!)! , eval: .outStanding)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "ممتاز"){
                    let b = Board(level: "المستوى الثالث", point: Int(points[j]!)! , eval: .excellent)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "جيد"){
                    let b = Board(level:"المستوى الثالث", point: Int(points[j]!)! , eval: .good)
                    boardArray[i] = b
                    i = i+1
                }
                if(evals[j] == "حاول مرة أخرى"){
                    let b = Board(level: "المستوى الثالث", point: Int(points[j]!)! , eval: .tryAgain)
                    boardArray[i] = b
                    i = i+1
                }
            }
            j = j+1
         }
        return boardArray
    }
      //return [Board(level: "المستوى الأول", point: 1, eval: .outStanding)]
  }

