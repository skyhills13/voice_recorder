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
    
    @IBAction func startRecording(sender : UIButton){
        stopRecordingButton.enabled = true;
        recordingLabel.text = "recording in progress"
        
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.text = "recording done"
        audioRecorder.stop()
    }
    
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text = "press to record"
        stopRecordingButton.enabled = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO path지정
        let dirPath = NSURL;
        
        
        var audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        audioRecorder = AVAudioRecorder.init(URL: dirPath, settings: <#T##[String : AnyObject]#>)
        
        audioRecorder.delegate = self
        // TODO prepareToRecord, record까지
        
 
        //이 위에 있는 것들을 start가 아니라 여기서 하는 것이 맞는지 확인.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag == true) {
            //TODO sender에 무엇을 넣어야 하나?
            performSegueWithIdentifier("stopRecordingSegue", sender: <#T##AnyObject?#>)
        } else {
            print("audio recording did not finish")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecordingSegue") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = audioRecorder.url
        } else {
            print("wrong segue. segue id = ", segue.identifier)
        }
    }
}
