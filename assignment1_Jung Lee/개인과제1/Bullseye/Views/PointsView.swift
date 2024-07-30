//
//  PointsView.swift
//  Bullseye
//
//  Created by 쩡이 on 10/10/21.
//

import SwiftUI

struct PointsView: View {
    @Binding var alertIsVisible: Bool
    @Binding var sliderValue: Double
    @Binding var game: Game
    
    var body: some View {
        let roundedValue = Int(sliderValue.rounded())
        let points = game.points(sliderValue: roundedValue)
        VStack {
            InstructionText(text: "The slider's value is")
            BigNumberText(text: "\(roundedValue)")
            BodyText(text: "You scored \(points) Points\n🎉🎉🎉")
            Button(action: {
                withAnimation {
                    alertIsVisible = false
                }
                game.startNewRound(points: points)
            }) {
                ButtonText(text: "Start New Round")
            }
        }
        .padding()
        .frame(maxWidth: 300.0)
        .background(Color("BackgroundColor"))
        .cornerRadius(Constants.General.roundedRectCornerRadius)
        .shadow(radius: 10.0, x: 5.0, y: 5.0)
    }
}

struct PointsView_Previews: PreviewProvider {
    static private var alertIsVisible = Binding.constant(false)
    static private var sliderValue = Binding.constant(50.0)
    static private var game = Binding.constant(Game())
    
    static var previews: some View {
        Group {
            PointsView(alertIsVisible: alertIsVisible, sliderValue: sliderValue, game: game)
                .previewLayout(.fixed(width: 568, height: 320))
            PointsView(alertIsVisible: alertIsVisible, sliderValue: sliderValue, game: game)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
