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
    var point: Float
    var eval: BoardEvaluation

    static var levels = [String?]()
    static var points = [String?]()
    static var evals = [String?]()
    
    //get child object
   static func getChild(){
        print("in booooaaardddd")
        let child = LocalStorage.childValue
        if child != nil{
            levels = getGameLevels(child: child!)
            points = getGamePoitns(child: child!)
            evals = getGameEvals(child: child!)
        }
    }
    
    //get child completed levels
    static func getGameLevels(child: Child) -> [String?]{
        
        let gameLevels = child.GameLevels.map({ $0["Level"] })
        print("game level \(gameLevels)")
        
  return gameLevels
    }
    
    //get child point of each level
   static func getGamePoitns(child: Child) -> [String?]{
       
       let gamePoitns = child.GameLevels.map({ $0["Score"] })
       print("game point \(gamePoitns)")
        
 return gamePoitns
    }
    
    //get child eval of each level
   static func getGameEvals(child: Child) -> [String?]{
       
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
    
  static func getBoards() -> [Board] {
      getChild()
      print("----in board extension")

        var boardArray = [Board]()
        var j = 0

        for l in levels {
            print("----in for board extension")

            if(l == "First"){
                print("----in first if board extension")

                if(evals[j] == "رائع"){
                    print("---- \(Float(points[j]!)!)")

                    let b = Board(level: "المستوى الأول", point: Float(points[j]!)! , eval: .outStanding)
                    print("---- \(b)")
                    boardArray.append(b)
                    //i = i+1
                }
                if(evals[j] == "ممتاز"){
                    let b = Board(level: "المستوى الأول", point: Float(points[j]!)! , eval: .excellent)
                    boardArray.append(b)
                   // i = i+1
                }
                if(evals[j] == "جيد"){
                    let b = Board(level: "المستوى الأول", point: Float(points[j]!)! , eval: .good)
                    boardArray.append(b)
                    //i = i+1
                }
                if(evals[j] == "حاول مرة أخرى"){
                    let b = Board(level: "المستوى الأول", point: Float(points[j]!)! , eval: .tryAgain)
                    boardArray.append(b)
                   // i = i+1
                }
                }
            else if (l == "Second"){
                if(evals[j] == "رائع"){
                    let b = Board(level: "المستوى الثاني", point: Float(points[j]!)! , eval: .outStanding)
                    boardArray.append(b)
                  //  i = i+1
                }
                if(evals[j] == "ممتاز"){
                    let b = Board(level: "المستوى الثاني", point: Float(points[j]!)! , eval: .excellent)
                    boardArray.append(b)
                   // i = i+1
                }
                if(evals[j] == "جيد"){
                    let b = Board(level: "المستوى الثاني", point: Float(points[j]!)! , eval: .good)
                    boardArray.append(b)
                    //i = i+1
                }
                if(evals[j] == "حاول مرة أخرى"){
                    let b = Board(level: "المستوى الثاني", point: Float(points[j]!)! , eval: .tryAgain)
                    boardArray.append(b)
                    //i = i+1
                }
                }
            else {
                if(evals[j] == "رائع"){
                    let b = Board(level: "المستوى الثالث", point: Float(points[j]!)!, eval: .outStanding)
                    boardArray.append(b)
                   // i = i+1
                }
                if(evals[j] == "ممتاز"){
                    let b = Board(level: "المستوى الثالث", point: Float(points[j]!)! , eval: .excellent)
                    boardArray.append(b)
                    //i = i+1
                }
                if(evals[j] == "جيد"){
                    let b = Board(level: "المستوى الثالث", point: Float(points[j]!)! , eval: .good)
                    boardArray.append(b)
                    //i = i+1
                }
                if(evals[j] == "حاول مرة أخرى"){
                    let b = Board(level: "المستوى الثالث", point: Float(points[j]!)! , eval: .tryAgain)
                    boardArray.append(b)
                    //i = i+1
                }
            }
            j = j+1
         }
        return boardArray
    }
  }

