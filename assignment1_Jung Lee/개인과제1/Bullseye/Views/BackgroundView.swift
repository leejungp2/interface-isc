//
//  BackgroundView.swift
//  Bullseye
//
//  Created by 쩡이 on 9/26/21.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var game: Game
    
    var body: some View {
        VStack {
            TopView(game: $game)
            Spacer()
            BottomView(game: $game)
        }
        .padding()
        .background(
            RingsView()
        )
    }
}

struct TopView: View {
    @Binding var game: Game
    @State var leaderboardIsShowing = false
    @State var infoIsShowing = false
    
    var body: some View {
        HStack {
            Button(action: {
                game.restart()
            }) {
                RoundedImageViewStroked(systemName: "arrow.counterclockwise")
            }
            Spacer()
            Button(action: {
                infoIsShowing = true
            }) {
                RoundedImageViewStroked(systemName: "info")
            }
            .sheet(isPresented: $infoIsShowing) {} content: {
                InfoView(infoIsShowing: $infoIsShowing, game: $game)
            }
            Button(action: {
                leaderboardIsShowing = true
            }) {
                RoundedImageViewFilled(systemName: "list.dash")
            }
            .sheet(isPresented: $leaderboardIsShowing) {} content: {
                LeaderboardView(leaderboardIsShowing: $leaderboardIsShowing, game: $game)
            }
            
        }
    }
}

struct NumberView: View {
    var title: String
    var text: String
    
    var body: some View {
        VStack(spacing: 5.0) {
            LabelText(text: title.uppercased())
            RoundRectTextView(text: text)
        }
    }
}

struct BottomView: View {
    @Binding var game: Game
    
    var body: some View {
        HStack {
            NumberView(title: "Score", text: String(game.score))
            Spacer()
            NumberView(title: "Round", text: String(game.round))
        }
    }
}

struct RingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            ForEach(1..<5) { ring in
                let size = CGFloat(ring * 100)
                let opacity = colorScheme == .dark ? 0.1 : 0.3
                Circle()
                    .stroke(lineWidth: 20.0)
                    .fill(
                        RadialGradient(colors:
                                        [
                                            Color("RingsColor").opacity(opacity * 0.8),
                                            Color("RingsColor").opacity(0.0)
                                        ],
                                       center: .center,
                                       startRadius: 100.0,
                                       endRadius: 300.0)
                    )
                    .frame(width: size, height: size)
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(game: .constant(Game()))
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
