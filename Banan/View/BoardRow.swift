//
//  BoardRow.swift
//  Banan
//
//  Created by Noura  on 11/09/1443 AH.
//

import SwiftUI

struct BoardRow: View {
    
    @State var percent : Float = 0
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
                VStack{
                    ProgressBarView(percent: self.$percent)
                }.onAppear() {
                    self.percent = b.point}.animation(.spring())
                HStack{
                    Text("١٠٠/"+"\(Int(b.point*100))".convertedDigitsToLocale(Locale(identifier: "AR")))
                        .foregroundColor(Color(red: 0.525, green: 0.502, blue: 0.486))
                        .font(.custom("Almarai", size: 18))
                    //.frame(maxWidth: .infinity, alignment: .trailing).padding(.trailing, 235)
                    Spacer()
                    
                }
                
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
            BoardRow(b:Board(level: "المستوى الأول", point: 70, eval: .excellent))
            BoardRow(b:Board(level: "المستوى الأول", point: 70, eval: .excellent))
        }
    }
}

struct ProgressBarView : View {
    @Binding var percent : Float
    
    var body: some View{
        
        ZStack(alignment: .leading){
            
            
            Capsule().fill(Color("Color3")).frame(height:22)
            
            Capsule().fill(Color("Color1")).frame(width:CGFloat(self.calPercent()), height: 22)
        }.rotationEffect(.degrees(-180)).overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("Color2"), lineWidth: 3)
        )
        
    }
    
    
    func calPercent()->Float{
        let width = UIScreen.main.bounds.width - 540
        return Float(width) * self.percent
    }
}
