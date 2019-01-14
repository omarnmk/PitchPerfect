//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Omar Namnakani on 23/10/2018.
//  Copyright © 2018 OmarNmk. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: recording functions
    
    @IBAction func startRecording(_ sender: Any) {
        
        configureUI(true)
        
        //get the app document directory and store it as string
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        //set a name for the recorded file
        let recordingName = "recordedVoice.wav"
        
        let pathArray = [dirPath, recordingName]
        
        //set the URL for the recorded file by combining the dirPath and the recordingName
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        //AVAudioSession is needed to record or playback audio
        //There is one instance of AVAudioSession as it is an abstraction of audio hardware in device and there is always one audio device, hence one AVAudioSession instance to be shared across all apps.
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        //create the audio file.
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        
        configureUI()
        
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("Recording was not successful")
        }
    }
    
    
    // MARK: Segue prepare funcion
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            
            //get an instance of PlaySoundsViewController to set its URL value
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            
            //set the URL value in PlaySoundsViewController
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }    
    
    // MARK: updating the UI Buttons function
    
    func configureUI(_ isRecording : Bool = false){
        recordingLabel.text = isRecording ? "Recording in progress": "Tap to record"
        startRecordingButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    }
    
}
