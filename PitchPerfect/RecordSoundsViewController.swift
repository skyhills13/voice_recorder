//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by soeunpark on 2016. 7. 12..
//  Copyright © 2016년 skyhills. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

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
        
//        audioRecorder.delegate = self
        // TODO audioRecorder init부터 prepare까지
        
 
        //이 위에 있는 것들을 start가 아니라 여기서 하는 것이 맞는지 확인.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if(identifier == "stopRecordingSegue") {
//            audioRecorder.url
            print("right segue")
        } else {
            print("wrong segue id")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}
