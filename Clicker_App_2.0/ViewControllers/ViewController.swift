//
//  ViewController.swift
//  Clicker_App_2.0
//
//  Created by SEAN ULRIC BUGUINA CHUA stu on 13/9/21.
//

import UIKit

class ViewController: UIViewController {
    
    var addon = 1
    var clicks = 0
    var counter = 0
    var totaltime = 10.00
    var timeLeft = 10.00
    var timeLeftToResume = 10.00
    var timer = Timer()
    var timer2 = Timer()
    var showalert = false
    
    
    @IBOutlet weak var CounterLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    @IBAction func ButtonClicked(_ sender: Any) {
        incrementCounter()
        clicks += 1
    }
    
    @IBAction func LeaveGame(_ sender: Any) {
        self.timer.invalidate()
        let timeralert = UIAlertController(title: "Are you sure?",
                                           message: "Changes may not be saved",
                                           preferredStyle: .alert)
        timeralert.addAction(UIAlertAction(title: "Continue",
                                           style: .destructive,
                                           handler:
                                            {
            (_) in
            self.performSegue(withIdentifier: "LeaveGame", sender: self)
            
        }))
        timeralert.addAction(UIAlertAction(title: "Cancel",
                                           style: .cancel,
                                           handler: { [self]
            (_) in
            self.dismiss(animated: true, completion: nil)
            for i in 1...20 {
                if (i % 2) != 0 {
                    self.timeLeftLabel.text = "Time Left: \(String(format : "%.2f", self.timeLeftToResume))"
                    self.resumetimer()
                } else {
                    self.timeLeftLabel.text = "Time Left: \(String(format : "%.2f", self.timeLeft))"
                    self.starttimer()
                }
            }
            
        }))
        
        self.present(timeralert, animated: true, completion: nil)
    }
    
    func points() {
        if counter >= 10 {
            pointsLabel.text = "Points: \(String(counter / 10))"
        }
    }
    
    func incrementCounter() {
        counter += addon
        if counter % 10 == 0 {
            addon += 1
        }
        CounterLabel.text = "\("$" + String(counter))"
        self.view.backgroundColor = UIColor(red: CGFloat(Double.random(in: 0...1)), green: CGFloat(Double.random(in: 0...1)), blue: CGFloat(Double.random(in: 0...1)), alpha: 1)
        points()
    }
    
    func configureitems() {
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func LeaveButtonTapped() {
        print("hello world")
    }
    
    @objc func selectorfunc() {
        if true == true {
        }
    }
    
    func resumetimer() {
        timeLeftToResume = timeLeft
        self.timer.invalidate()
        self.timer2 = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
            self.timeLeftToResume -= 0.01
            if self.timeLeftToResume <= 0 {
                self.timer2.invalidate()
                self.performSegue(withIdentifier: "showResults", sender: nil)
            }
            self.timeLeftLabel.text = "TimeLeft: \(String(format:"%.2f",self.timeLeftToResume))"
        })
    }
    
    func starttimer() {
        timeLeft = timeLeftToResume
        self.timer2.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
            self.timeLeft -= 0.01
            if self.timeLeft <= 0 {
                self.timer.invalidate()
                self.performSegue(withIdentifier: "showResults", sender: nil)
            }
            self.timeLeftLabel.text = "TimeLeft: \(String(format:"%.2f",self.timeLeft))"
        })
    }
    
    
    override func viewDidLoad() {
        timeLeft = totaltime
        timeLeftToResume = totaltime
        super.viewDidLoad()
        configureitems()
        pointsLabel.text = "Points: 0 ;-;"
        CounterLabel.text = "\("$" + String(counter))"
        timeLeftLabel.text = "Time Left: \(String(format : "%.2f", self.timeLeft))"
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        starttimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResults" {
            let destinationViewController =
            segue.destination as! ResultsViewController
            destinationViewController.numberofclicks = self.counter
            destinationViewController.allocatedTime = self.totaltime
            destinationViewController.moneyearned = self.clicks
        }
    }
}


