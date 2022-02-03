//
//  ViewController.swift
//  Project2-Guesstheflag
//
//  Created by Irakli Sokhaneishvili on 03.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionCounter = 0
    
    let totalQuestions = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreTapped))
        
        // Button 1
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.cornerRadius = 20.0
        button1.clipsToBounds = true
        // Button 2
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.cornerRadius = 20.0
        button2.clipsToBounds = true
        // Button 3
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.cornerRadius = 20.0
        button3.clipsToBounds = true

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) 🏆\(score)"
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        questionCounter += 1
        if questionCounter == 4 {
            let ac = UIAlertController(title: "Game Over", message: "Your final score was \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .destructive, handler: askQuestion))
            
            present(ac, animated: true)
            score = 0
            questionCounter = 0
        } else {
            let ac = UIAlertController(title: title, message: "Thats the flag of \(countries[sender.tag])", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    
    @objc func scoreTapped() {
        let ac = UIAlertController(title: "Current score", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }

}

