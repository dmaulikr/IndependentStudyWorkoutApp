//
//  exerciseViewController.swift
//  HelloWorld
//
//  Created by Students on 11/9/15.
//  Copyright © 2015 RonOppenheimer. All rights reserved.
//

import UIKit
import AVFoundation

class exerciseViewController: UIViewController {

    var timerCount = 50
    var timerRunning = true
    var timer = NSTimer()
    var exerciseNumber = 0
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "goToRest") {
        }
    }
    
    func Timer() {
        if timerRunning == true {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("Counting"), userInfo: nil, repeats: true)
        playSound()
        }
    }
    
    @IBOutlet var nameLabel: UILabel!

    
    @IBOutlet var timerLabel: UILabel!
    func Counting() {
        exerciseNumber = SharingManager.sharedInstance.exerciseCount
        exerciseNumber = 1 + exerciseNumber
        SharingManager.sharedInstance.exerciseCount = exerciseNumber
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = "\(timerCount)"
            audioPlayer!.play()
            let progressCount = 50 - timerCount
            let fractionalProgress = Float(progressCount) / 50
            let animated = progressCount != 0
            progressBar.setProgress(fractionalProgress, animated: animated)
        }
        else if exerciseNumber == 2 {
            performSegueWithIdentifier("goToHome", sender: nil)
        }
        else {
            do {
                try performSegueWithIdentifier("goToRest", sender: nil)
            }
            catch {
                performSegueWithIdentifier("goToHome", sender: nil)
            }
            }
        
        }
    
    

    @IBOutlet var progressBar: UIProgressView!

    
    func timerStop() {
        timer.invalidate()
        timerRunning = false
    }
    
    func playSound() {
        
        // Set the sound file name & extension
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Tick", ofType: "mp3")!)
        
        do {
            // Preperation
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        
        // Play the sound
        let error: NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        audioPlayer!.prepareToPlay()
        
    }
    
    @IBAction func startButton(sender: UIButton) {
        if timerRunning == false
        {
            timerRunning = true
            Timer()
            sender.setTitle("Stop", forState: UIControlState.Normal)
        }
        else
        {
            timerStop()
            sender.setTitle("Start", forState: UIControlState.Normal)
        }
        
    }
    
    
    @IBAction func restartButton(sender: UIButton) {
        timerStop()
        timerCount = 50
        timerLabel.text = "50"
    }
    

    @IBAction func exitButton(sender: UIButton) {
        timerStop()
        timerCount = 0
        performSegueWithIdentifier("goToHome", sender: nil)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
