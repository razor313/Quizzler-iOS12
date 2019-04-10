//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    var userAnswer:Bool = false
    var corectAnswer:Bool = false
    let allQuestion = QuestionBank()
    var questionIndex : Int = 0
    var totalUserScore:Int = 0
    var userScoreString:String = "0"
    var endOver:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if endOver {
            endOver = false
            makeEndAlert()
            return
        }
        if sender.tag == 1 {
            userAnswer = true
        } else {
            userAnswer = false
        }
        checkAnswer()
    }
    
    func updateUI() {
        questionIndex += 1
        progressLabel.text = "\(questionIndex)\\\(allQuestion.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestion.list.count)) * CGFloat(questionIndex)
        if (questionIndex < allQuestion.list.count) {
            nextQuestion()
        } else {
            makeEndAlert()
        }
    }
    
    func nextQuestion() {
        questionLabel.text = allQuestion.list[questionIndex].question
    }
    
    func checkAnswer() {
        corectAnswer = allQuestion.list[questionIndex].answer
        if userAnswer == corectAnswer {
            ProgressHUD.showSuccess("Correct")
            scoreUp(score:10)
        } else {
            ProgressHUD.showError("Wrong!")
        }
        updateUI()
    }
    
    func startOver() {
        questionIndex = 0
        totalUserScore = 0
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestion.list.count))
        progressLabel.text = "\(questionIndex)\\\(allQuestion.list.count)"
        scoreUp(score: totalUserScore)
        nextQuestion()
    }
    
    func scoreUp(score:Int) {
        totalUserScore = totalUserScore + score
        scoreLabel.text = "Score : \(totalUserScore)"
    }

    func makeEndAlert() {
        let alert = UIAlertController(title: "This is endup of the quiz", message: "Do want to start over again?", preferredStyle: .alert)
        let start = UIAlertAction(title: "Start", style: .default) { (UIAlertAction) in
            self.startOver()
        }
        let done = UIAlertAction(title: "Done", style: .default) { (UIAlertAction) in
            self.endOver = true
        }
        alert.addAction(start)
        alert.addAction(done)
        self.present(alert, animated: true, completion: nil)
    }
}
