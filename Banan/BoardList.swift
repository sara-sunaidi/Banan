//
//  BoardList.swift
//  Banan
//
//  Created by Noura  on 07/09/1443 AH.
//

import SwiftUI

struct BoardList: View {
    
    let boards = Board.getBoards()
//    Board(level: "المستوى الأول", points: 70, eval: .outStanding)
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
       }
    
    var body: some View {

        
       
        
        VStack(alignment: .leading, spacing: 0){
//            LabelledDivider(label: "الإنجازات")
            if boards.isEmpty{
                Text("لا توجد لديك إنجازات")
                    .foregroundColor(Color(red: 0.137, green: 0.263, blue: 0.271))
                    .font(.custom("Almarai", size: 23))
            }else{
            List(boards){
                board in
                BoardRow(b: board)
                    .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .padding(.all, 0)
        
        .listRowInsets(EdgeInsets()) // hack for ios14
            .background(Color(red: 0.949, green: 0.953, blue: 0.961))

        }
        }
    
}

}

struct BoardList_Previews: PreviewProvider {
    static var previews: some View {
        BoardList()
    }
}

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 20, color: Color = Color(red: 0.525, green: 0.502, blue: 0.486) ) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
                .font(.custom("Almarai", size: 25))
            line
        }
    }

    var line: some View {
        VStack {
//            Divider().background(Color(red: 0.525, green: 0.502, blue: 0.486) ) }.padding(horizontalPadding)
//            .frame(maxHeight:3)
            Rectangle()
                .fill(Color(red: 0.643, green: 0.635, blue: 0.678) )
                .frame(height: 2)
                .padding(horizontalPadding)
            
    }
}
}
struct ExDivider: View {
    let color: Color = Color(red: 0.525, green: 0.502, blue: 0.486)
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}


