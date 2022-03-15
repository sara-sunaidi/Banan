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
                //.frame(width: 160.0, height: 160.0)
                .padding(20.0)
                
                .onAppear(){
//                    self.progressValue = 0.40
                    self.progressValue = passedVal
                }
                .background(Color.clear)
//            Button("Increment") {
//                if (progressValue) < 1.0 {
//                    self.progressValue += 0.10
//                } else {
//                    progressValue -= 1.0
//                }
//            }
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
            
            Text("\(Int(progress*100))%")
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
