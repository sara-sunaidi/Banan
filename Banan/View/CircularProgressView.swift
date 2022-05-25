//
//  CircularProgressView.swift
//  Banan
//
//  Created by Sara Alsunaidi on 14/03/2022.
//

import SwiftUI

struct CircularProgressView: View {
    //Binding ?
    @State var progressValue: Float = 0.0
    var passedVal: Float
    var body: some View {
        VStack {
            ProgressBar(progress: self.$progressValue)
                .padding(20.0)
                
                .onAppear(){

                    self.progressValue = passedVal
                }
                .background(Color.clear)

        }
    }
}
struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color.white
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress,1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2.0))
            
            Text("\(Int(progress*100))%".convertedDigitsToLocale(Locale(identifier: "AR")))
                .foregroundColor(Color(red: 35 / 255, green: 66 / 255, blue: 68 / 255))
                .font(.system(size: 20))
                .fontWeight(.black)
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(passedVal: 0.0)
    }
}
