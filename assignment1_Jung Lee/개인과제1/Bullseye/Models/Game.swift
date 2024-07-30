//
//  Game.swift
//  Bullseye
//
//  Created by 쩡이 on 2021/09/12.
//

import Foundation

struct LeaderboardEntry {
    let average: Int
    let date: Date
}

struct Game {
    var target = Int.random(in: 1..<100)
    var score = 0
    var round = 1
    var average = 0
    var leaderboardEntries: [LeaderboardEntry] = []
    
    init(loadTestData: Bool = false) {
        if loadTestData {
            leaderboardEntries.append(LeaderboardEntry(average: 100, date: Date()))
            leaderboardEntries.append(LeaderboardEntry(average: 80, date: Date()))
            leaderboardEntries.append(LeaderboardEntry(average: 200, date: Date()))
            leaderboardEntries.append(LeaderboardEntry(average: 143, date: Date()))
            leaderboardEntries.append(LeaderboardEntry(average: 50, date: Date()))
        }
    }


func points(sliderValue: Int) -> Int {
    let difference = abs(target - sliderValue)
    let bonus: Int
    
    if difference == 0 {
        bonus = 100
    } else if difference <= 2 {
        bonus = 50
    } else {
        bonus = 0
    }
    
    return 100 - difference + bonus
}

mutating func addToLeaderboard(point: Int) {
    average = score / round
    if average != 0 && round > 3 {
        leaderboardEntries.append(LeaderboardEntry(average: average, date: Date()))
    leaderboardEntries.sort {
        $0.average > $1.average}
    }
}

mutating func startNewRound(points: Int) {
    score += points
    round += 1
    target = Int.random(in: 1..<100)
    addToLeaderboard(point: points)
}

mutating func restart() {
    score = 0
    round = 1
    target = Int.random(in: 1..<100)
}
}
