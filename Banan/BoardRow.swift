//
//  BoardRow.swift
//  Banan
//
//  Created by Madawi Ahmed on 03/09/1443 AH.
//

import SwiftUI

struct BoardRow: View {
    
    var b: Board
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .trailing, spacing: 8
                   , content: {
                Text(b.level)
                    .foregroundColor(Color(red: 0.137, green: 0.263, blue: 0.271))
                    .font(.custom("Almarai", size: 23))
               
                HStack(alignment: .bottom, spacing: 0, content:{
                    
                    Text("مجموع النقاط")
                        .foregroundColor(Color(red: 0.525, green: 0.502, blue: 0.486))
                        .font(.custom("Almarai", size: 18))
                    Image("shinyStar2")
                        .resizable()
                        .frame(width: 23, height: 23)
                })
                
                Text("بروقرس بار")
            })
            
            Image(b.getEvaluationInfo())
                .resizable()
                .padding()
                .frame(width: 150, height: 150)
                
        }
        .listRowBackground(Color.clear)
//        .background(Color.clear)
//        Text("Im in your VC HOORAAY !!")
//            .padding()
//            .foregroundColor(.red)
//            .frame(width: 150, height: 150, alignment: .center)
//            .background(Color.yellow)
    }
}

struct BoardRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BoardRow(b:Board(level: "المستوى الأول", points: 70, eval: .excellent))
            BoardRow(b:Board(level: "المستوى الأول", points: 70, eval: .excellent))
        }
    }
}
