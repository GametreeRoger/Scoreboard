//
//  ViewController.swift
//  Scoreboard
//
//  Created by 張又壬 on 2021/7/28.
//

import UIKit

class ScoreboardViewController: UIViewController {
    let MAX_RECORD = 12
    var score: Score!
    var scoreRecord: [Score] = []
    
    @IBOutlet weak var leftScoreButton: UIButton!
    @IBOutlet weak var rightScoreButton: UIButton!
    
    @IBOutlet weak var leftNameLabel: UILabel!
    @IBOutlet weak var rightNameLabel: UILabel!
    
    @IBOutlet weak var leftGameScoreLabel: UILabel!
    @IBOutlet weak var rightGameScoreLabel: UILabel!
    
    @IBOutlet weak var leftServe: UILabel!
    @IBOutlet weak var rightServe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        score = Score(person_A: Person(name: "Peter", game: 0, score: 0), person_B: Person(name: "Hook", game: 0, score: 0), isLeftA: true, isServeA: true, serveCount: 0)
        
        recordPush()
        updateView()
    }
    
    func addScore(isA: Bool) {
        if isA {
            score.person_A.score += 1
        } else {
            score.person_B.score += 1
        }
        
        if score.person_A.score >= 10 && score.person_B.score >= 10 {
            let difference = abs(score.person_A.score - score.person_B.score)
            if difference > 1 {
                gameSetAlert()
            }
        } else if score.person_A.score > 10 || score.person_B.score > 10 {
            gameSetAlert()
        }
    }
    
    func addGameScore() {
        if score.person_A.score > score.person_B.score {
            score.person_A.game += 1
        } else {
            score.person_B.game += 1
        }
        score.person_A.score = 0
        score.person_B.score = 0
        score.serveCount = 0
        updateView()
    }
    
    func addServerCount() {
        score.serveCount += 1
        
        if score.person_A.score >= 10, score.person_B.score >= 10 {
            score.serveCount = 0
            score.isServeA = !score.isServeA
        } else {
            if score.serveCount == 2 {
                score.serveCount = 0
                score.isServeA = !score.isServeA
            }
        }
    }
    
    func updateView() {
        leftNameLabel.text = score.isLeftA ? score.person_A.name : score.person_B.name
        rightNameLabel.text = score.isLeftA ? score.person_B.name : score.person_A.name
        
        leftGameScoreLabel.text = score.isLeftA ? String(score.person_A.game) : String(score.person_B.game)
        rightGameScoreLabel.text = score.isLeftA ? String(score.person_B.game) : String(score.person_A.game)
        
        leftScoreButton.setTitle(score.isLeftA ? String(score.person_A.score) : String(score.person_B.score), for: .normal)
        rightScoreButton.setTitle(score.isLeftA ? String(score.person_B.score) : String(score.person_A.score), for: .normal)
        
        if score.isLeftA {
            leftServe.isHidden = !score.isServeA
            rightServe.isHidden = score.isServeA
        } else {
            leftServe.isHidden = score.isServeA
            rightServe.isHidden = !score.isServeA
        }
    }
    
    func gameSetAlert() {
        let alertController = UIAlertController(title: nil, message: "Game Set", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.addGameScore()
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func recordPush() {
        scoreRecord.append(score)
        if scoreRecord.count > MAX_RECORD {
            scoreRecord.removeFirst()
        }
    }
    
    func recordPop() -> Score? {
        if scoreRecord.count == 1 {
            return scoreRecord.first
        } else {
            scoreRecord.removeLast()
        }
        
        return scoreRecord.last
    }

    @IBAction func addScore(_ sender: UIButton) {
        if sender == leftScoreButton {
            addScore(isA: score.isLeftA)
        } else {
            addScore(isA: !score.isLeftA)
        }
        addServerCount()
        recordPush()
        updateView()
    }
    
    @IBAction func rewind(_ sender: Any) {
        score = recordPop()
        updateView()
    }
    
    @IBAction func changeSide(_ sender: Any) {
        score.isLeftA = !score.isLeftA
        recordPush()
        updateView()
    }
    
    @IBAction func reset(_ sender: Any) {
        score.clear()
        recordPush()
        updateView()
    }
}
