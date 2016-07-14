//
//  ViewController.swift
//  PitchPerfect
//
//  Created by soeunpark on 2016. 7. 12..
//  Copyright © 2016년 skyhills. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var audioFile: AVAudioFile!
    
    enum ButtonType: Int {case Echo = 0, Reverb, Low, High, Slow, Fast}
    
    @IBAction func playButtonPressed(sender: UIButton){
        configureUI(.Playing)
        if let pressedButtonType = ButtonType(rawValue: sender.tag) {
            switch pressedButtonType{
            case .Echo:
                playSound(echo : true)
            case .Reverb:
                playSound(reverb : true)
            case .Low:
                playSound(pitch : -1000.0)
            case .High:
                playSound(pitch : 1000.0)
            case .Slow:
                playSound(rate: 0.5)
            case .Fast:
                playSound(rate : 3.0)
            }
        }
    }
    
    @IBAction func stopButtonPressed(sender: UIButton){
        stopAudio()
        configureUI(.NotPlaying)
    }
    
    override func viewWillAppear(animated: Bool) {
        setupAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

