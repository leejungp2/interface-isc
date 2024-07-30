class dartGame {
    
    var totalScore = 0
    var Score = 0
    var round = 1
    var roundScore = 0
    var Multiply = 1
    var multiplyText = "Single"
    var breaker = false
    
    func throwDart() {
        var scoreScope = [50]
        for i in 0...20{
            scoreScope.append(i)
        }
        let number = Int.random(in: 0..<scoreScope.count)
        Score = scoreScope[number]
    }
    
    func randomNumber() -> Int {
        let rdm = Int.random(in:1...10)
        if [1].contains(rdm) {
            return 3
        }
        else if [2,3].contains(rdm) {
            return 2
        }
        else {
            return 1
        }
    }
    
    func multiplier(score:Int) {
        if score == 0 {
            Multiply = 1
        }
        else if score == 50 {
            Multiply = 1
        }
        else {
            Multiply = randomNumber()
        }
    }
    
    func changeToText(multiply : Int) -> String {
        if multiply == 1 {
            multiplyText = "Single"
        }
        if multiply == 2 {
            multiplyText = "Double"
        }
        else if multiply == 3 {
            multiplyText = "Triple"
        }
        return multiplyText
    }
    
    func play() {
        for _ in 1...9 {
            print("Round: \(round)")
            for trial in 1...3 {
                throwDart()
                multiplier(score : Score)
                
                let finalScore = Score * Multiply
                roundScore += finalScore
                totalScore += finalScore
                
                if totalScore > 301 {
                    totalScore = totalScore - roundScore
                    print("Trial \(trial) : It was \(changeToText(multiply: Multiply)), and you scored \(finalScore).")
                    print("❤️‍🔥BURST❤️‍🔥 You lost all the points from this round. Your score is still \(totalScore).")
                    break
                }
    
                print("Trial \(trial) : It was \(changeToText(multiply: Multiply)), and you scored \(finalScore). Total score is \(totalScore)")
                
                
                if totalScore == 301 {
                    print("CONGRATS! You won the game in \(round) rounds!")
                    breaker = true
                    break
                }
            }
            round += 1
            roundScore = 0
            Score = 0
            print("\n")
            if breaker == true {
                break
            }
        }
        if breaker == false {
            print("GAME OVER. You need \(301-totalScore) more points to win.")
        }
        
    }
   
}

