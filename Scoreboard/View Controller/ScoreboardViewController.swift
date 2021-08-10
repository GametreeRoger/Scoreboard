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
    var goingForwards: Bool = false
    var settings: Settings!
    
    @IBOutlet weak var leftScoreButton: UIButton!
    @IBOutlet weak var rightScoreButton: UIButton!
    
    @IBOutlet weak var leftNameLabel: UILabel!
    @IBOutlet weak var rightNameLabel: UILabel!
    
    @IBOutlet weak var leftGameScoreLabel: UILabel!
    @IBOutlet weak var rightGameScoreLabel: UILabel!
    
    @IBOutlet weak var leftServe: UILabel!
    @IBOutlet weak var rightServe: UILabel!
    
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var changeSideButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        score = Score(person_A: Person(name: "Player1", game: 0, score: 0), person_B: Person(name: "Player2", game: 0, score: 0), isLeftA: true, isServeA: true, serveCount: 0)
        
        if settings == nil {
            settings = Settings(player1: score.person_A.name, player2: score.person_B.name, theme: .Default)
        }
        
        updateColor()
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
    
    func recordChangeName(nameA: String, nameB: String) {
        if scoreRecord.count == 0 {
            return
        }
        
        for index in 0..<scoreRecord.count {
            scoreRecord[index].changeName(nameA: nameA, nameB: nameB)
        }
    }
    
    func updateColor() {
        var textColorName = ""
        var serveColorName = ""
        var resetColorName = ""
        var backgroundColorName = ""
        let theme = settings.theme
        textColorName = "\(theme.getString)_TextColor"
        serveColorName = "\(theme.getString)_ServeColor"
        resetColorName = "\(theme.getString)_ResetColor"
        backgroundColorName = "\(theme.getString)_BackgroundColor"

        leftScoreButton.setTitleColor(UIColor(named: textColorName), for: .normal)
        rightScoreButton.setTitleColor(UIColor(named: textColorName), for: .normal)
        leftNameLabel.textColor = UIColor(named: textColorName)
        rightNameLabel.textColor = UIColor(named: textColorName)
        leftGameScoreLabel.textColor = UIColor(named: textColorName)
        rightGameScoreLabel.textColor = UIColor(named: textColorName)
        rewindButton.setTitleColor(UIColor(named: textColorName), for: .normal)
        changeSideButton.setTitleColor(UIColor(named: textColorName), for: .normal)
        resetButton.setTitleColor(UIColor(named: resetColorName), for: .normal)
        leftServe.textColor = UIColor(named: serveColorName)
        rightServe.textColor = UIColor(named: serveColorName)
        view.backgroundColor = UIColor(named: backgroundColorName)
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
    
    @IBSegueAction func showSettings(_ coder: NSCoder) -> SettingsTableViewController? {
        return SettingsTableViewController(coder: coder, settings: settings, delegate: self)
    }
}

extension ScoreboardViewController: SettingDelegate {
    func settingData(data: Settings) {
        settings = data
        score.person_A.name = settings?.player1 ?? "player1"
        score.person_B.name = settings?.player2 ?? "player2"
        recordChangeName(nameA: score.person_A.name, nameB: score.person_B.name)
        updateView()
        updateColor()
    }
}
