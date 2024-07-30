import UIKit

let winScore: Int = 301
let totalRound: Int = 10
var round: Int = 1
var count: Int = 0
var score: Int = 0
var totalScore: Int = 0

// MARK: - 1. 랜덤 숫자 뽑는 함수(0~20, 50중 랜덤)
var scoreScope: [Int] = Array<Int>(0...20)
scoreScope.append(50)
scoreScope

func randomNumber(list: [Int]) -> Int {
    return list.randomElement()!
}


// MARK: - 2. Single, Double, Triple 선택 함수
func getMultiplierArray(single: Int, double: Int, triple: Int) -> [Int] {
    var arr: [Int] = []
    
    for _ in 0..<single {
        arr.append(1)
    }
    
    for _ in 0..<double {
        arr.append(2)
    }

    for _ in 0..<triple {
        arr.append(3)
    }
    
    return arr
}


//MARK: - 랜덤 숫자와 multiplier를 구해 리턴하는 함수
let multiplierArray: [Int] = getMultiplierArray(single:70, double: 20, triple: 10)
let multiplier = multiplierArray.randomElement()!

func getScore(number: Int) -> (point: Int, multiplier: Int) {
    if number == 0 || number == 50 {
        return (number, 1)
    } else {
        let multiplier = multiplierArray.randomElement()!
        return (number, multiplier)
    }
}


//MARK: - 실행 함수
func play() {
    var tempScore: Int = 0
    
    for _ in 1...totalRound {
        tempScore = totalScore
        score = 0
        
        for _ in 0..<3 { // 1라운드 당 3회 던지는 반복문
            let randomNumber = randomNumber(list:scoreScope)
            let dartInfo = getScore(number: randomNumber)
            let point = dartInfo.point
            let multiplyNumber = dartInfo.multiplier
            var multiplyText: String = ""
            
            switch multiplyNumber {
            case 1:
                multiplyText = "Single"
            case 2:
                multiplyText = "Double"
            case 3:
                multiplyText = "Triple"
            default:
                multiplyText = "Error"
            }
            
            score = point * multiplyNumber
            
            // BURST인지 체크
            if tempScore + score > winScore {
                print("❤️‍🔥BURST❤️‍🔥 You lost all the points from \(round) round.")
                print("* Reason - Your total score has exceeded 301 points as \(tempScore + score).")
                break
            } else {
                tempScore += score
            }
            
            print("Round: \(round) - Score: \(point), \(multiplyText), Total Score: \(tempScore)")
        }
        
        if tempScore <= winScore {
            totalScore = tempScore
        }
      
        // 우승 점수 넘겼는지 체크
        if totalScore == winScore {
            print("----------------You WIN!----------------")
            print("CONGRATS! You won the game in \(round) rounds!")
            print("----------------------------------------")
            break
        }
        
        round += 1
    }
    
    if totalScore < winScore {
        print("----------------GAME OVER----------------")
        print("Your current score is \(totalScore). You need \(winScore - totalScore) more points to win.")
        print("-----------------------------------------")
    }
}

play()
