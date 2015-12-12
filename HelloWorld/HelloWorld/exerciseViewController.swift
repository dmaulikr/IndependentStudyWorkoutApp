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

    var timerCount = 10
    var timerRunning = true
    var timer = NSTimer()
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer()
        restartEnabled.enabled = false
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
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = "\(timerCount)"
            audioPlayer!.play()
            let progressCount = 10 - timerCount
            let fractionalProgress = Float(progressCount) / 10
            let animated = progressCount != 0
            progressBar.setProgress(fractionalProgress, animated: animated)
        }
        else {
                performSegueWithIdentifier("goToRest", sender: nil)
//                do {
//                    try performSegueWithIdentifier("goToRest", sender: nil)
//                }
//                catch {
//                    performSegueWithIdentifier("goToHome", sender: nil)
//                }
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
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
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
            restartEnabled.enabled = false
        }
        else
        {
            timerStop()
            sender.setTitle("Start", forState: UIControlState.Normal)
            restartEnabled.enabled = true
        }
        
    }
    
    @IBOutlet var restartEnabled: UIButton!
    
    @IBAction func restartButton(sender: UIButton) {
        timerStop()
        timerCount = 10
        timerLabel.text = "10"
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
