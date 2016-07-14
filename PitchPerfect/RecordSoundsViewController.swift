//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by soeunpark on 2016. 7. 12..
//  Copyright © 2016년 skyhills. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text = "press to record"
        stopRecordingButton.enabled = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startRecording(sender: AnyObject) {
        stopRecordingButton.enabled = true
        recordingLabel.text = "recording in progress"
        
        let dirPath =  NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let fileName = formatter.stringFromDate(currentDateTime)+".wav"
        
        let pathComponents = [dirPath, fileName]
        let recordingFilePath = NSURL.fileURLWithPathComponents(pathComponents)
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//        try! audioSession.setActive(true)
        
        try! audioRecorder = AVAudioRecorder(URL: recordingFilePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        startRecordingButton.enabled = false
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.text = "recording done"
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        audioRecorder.stop()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            performSegueWithIdentifier("stopRecordingSegue", sender: audioRecorder.url)
        } else {
            print("audio recording did not finish")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecordingSegue") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = sender as! NSURL
        } else {
            print("wrong segue. segue id = ", segue.identifier)
        }
    }
}
