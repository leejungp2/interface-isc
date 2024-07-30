//
//  LeaderboardView.swift
//  Bullseye
//
//  Created by 쩡이 on 10/17/21.
//

import SwiftUI

struct LeaderboardView: View {
    @Binding var leaderboardIsShowing: Bool
    @Binding var game: Game
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 10.0) {
                HeaderView(leaderboardIsShowing: $leaderboardIsShowing)
                LabelView()
                ScrollView {
                    VStack(spacing: 10.0) {
                        ForEach(game.leaderboardEntries.indices) { index in
                            let leaderboardEntry = game.leaderboardEntries[index]
                            RowView(index: index, score: leaderboardEntry.average, date: leaderboardEntry.date)
                        }
                    }
                }
            }
        }
    }
}

struct RowView: View {
    let index: Int
    let score: Int
    let date: Date
    
    var body: some View {
        HStack {
            RoundedTextView(text: String(index))
            Spacer()
            ScoreText(score: score)
                .frame(width: Constants.Leaderboard.leaderboardScoreColWidth)
            Spacer()
            DateText(date: date)
                .frame(width: Constants.Leaderboard.leaderboardDateColWidth)
        }
        .background(
            RoundedRectangle(cornerRadius: .infinity)
                .strokeBorder(Color("LeaderboardRowColor"), lineWidth: Constants.General.strokeWidth)
        )
        .padding(.leading)
        .padding(.trailing)
        .frame(maxWidth: Constants.Leaderboard.leaderboardMaxRowWidth)
    }
}

struct HeaderView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var leaderboardIsShowing: Bool
    
    var body: some View {
        ZStack {
            HStack {
                if verticalSizeClass == .regular && horizontalSizeClass == .compact {
                    BigBoldText(text: "Leaderboard").padding(.leading)
                    Spacer()
                } else {
                    BigBoldText(text: "Leaderboard")
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    leaderboardIsShowing = false
                }) {
                    RoundedImageViewFilled(systemName: "xmark")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 15))
                }
            }
        }
    }
}

struct LabelView: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: Constants.General.roundedViewLength)
            Spacer()
            LabelText(text: "Score")
                .frame(width: Constants.Leaderboard.leaderboardScoreColWidth)
            Spacer()
            LabelText(text: "Date")
                .frame(width: Constants.Leaderboard.leaderboardDateColWidth)
        }
        .padding(.leading)
        .padding(.trailing)
        .frame(maxWidth: Constants.Leaderboard.leaderboardMaxRowWidth)
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeaderboardView(leaderboardIsShowing: Binding.constant(true),
                            game: Binding.constant(Game(loadTestData: true)))
            LeaderboardView(leaderboardIsShowing: Binding.constant(true),
                            game: Binding.constant(Game(loadTestData: true)))
                .previewLayout(.fixed(width: 568, height: 320))
            LeaderboardView(leaderboardIsShowing: Binding.constant(true),
                            game: Binding.constant(Game(loadTestData: true)))
                .preferredColorScheme(.dark)
            LeaderboardView(leaderboardIsShowing: Binding.constant(true),
                            game: Binding.constant(Game(loadTestData: true)))
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
