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
        startRecordingButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        stopRecordingButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        recordingLabel.text = "press to record"
        stopRecordingButton.enabled = false;
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
        
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            showAlert("error", message: "something went wrong while recording", alertType: Alerts.AudioSessionError)
        }
        
        do {
            try audioRecorder = AVAudioRecorder(URL: recordingFilePath!, settings: [:])
        } catch {
            showAlert("error", message: "something went wrong while recording", alertType: Alerts.AudioRecorderError)
        }
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        startRecordingButton.enabled = false
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.text = "recording done"
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setActive(false)
        } catch {
            showAlert("error", message: "something went wrong while recording", alertType: Alerts.AudioSessionError)
        }
        audioRecorder.stop()
        startRecordingButton.enabled = true
        stopRecordingButton.enabled = false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            performSegueWithIdentifier("stopRecordingSegue", sender: audioRecorder.url)
        } else {
            showAlert("error", message: "something went wrong while recording", alertType: Alerts.RecordingFailedTitle)
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
    
    func showAlert(title: String, message: String, alertType : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: alertType, style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
