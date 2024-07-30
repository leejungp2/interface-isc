//
//  InfoView.swift
//  Bullseye
//
//  Created by 쩡이 on 2021/11/02.
//

import SwiftUI

struct InfoView: View {
    
    @Binding var infoIsShowing: Bool
    @Binding var game: Game
    
    var body: some View {
    HStack{
        VStack {
            InfoBigBoldText(text: "How To Play")
            HStack {
                RoundedTextView(text: "1")
                InfoBodyText(text: "Drag the slider to estimate the value.")}
            HStack {
                RoundedTextView(text: "2")
                InfoBodyText(text: "Bonus points are given to close value.")}
            HStack {
                RoundedTextView(text: "3")
                InfoBodyText(text: "Check your score on the leaderboard.")}
            Button(action: {
                withAnimation {
                    infoIsShowing = false
                }
            }) {
                ButtonText(text: "Start Game")
            }
            
        }
    }
        .padding()
        .frame(maxWidth: 300.0)
        .background(Color("BackgroundColor"))
        .cornerRadius(Constants.General.roundedRectCornerRadius)
        .shadow(radius: 10.0, x: 5.0, y: 5.0)
    }


struct InfoView_Previews: PreviewProvider {
    static private var infoIsShowing = Binding.constant(false)
    static private var game = Binding.constant(Game())
            
    static var previews: some View {
        Group {
            InfoView(infoIsShowing: infoIsShowing, game: game)
                .previewLayout(.fixed(width: 568, height: 400))
            InfoView(infoIsShowing: infoIsShowing, game: game)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 568, height: 400))
            }
        }
    }
}
