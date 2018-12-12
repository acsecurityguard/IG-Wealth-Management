//
//  SecondViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-04.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class AdvisorsViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var accountlabel: UILabel!
    @IBOutlet weak var accountpick: UIPickerView!
    @IBOutlet weak var increaseView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var tapLabel: UILabel!
    
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    @IBOutlet weak var answerLabel: UITextView!
    
    @IBAction func request(_ sender: Any) {
        load.isHidden = false
    }
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        increaseView.isHidden = true
        load.isHidden = true
        recordButton.isEnabled = false  //2
        
        speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            var isButtonEnabled = false
            
            switch authStatus {  //5
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.recordButton.isEnabled = isButtonEnabled
            }
        }
    }
    
    func taxfree(){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.ambient, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        print(questionText.text!)
        var utterance = AVSpeechUtterance(string: "")
        if(questionText.text!.contains("total")){
              utterance = AVSpeechUtterance(string: "... Your life time contributions at I.G Wealth Management is 47800 dollars")
            answerLabel.text = "Your life time contributions at IG Wealth Management is CAD 47,800.00"
        } else if(questionText.text!.contains("estimated")){
            utterance = AVSpeechUtterance(string: "... Your estimated life time contributions in this account at I.G Wealth Management after this one time contribution will be 52800 dollars ")
            answerLabel.text = "Your estimated life time contributions in this account at IG Wealth Management after this one time contribution will be CAD 52,800.00"
        }else if(questionText.text!.contains("Sterling")){
            utterance = AVSpeechUtterance(string: "... Hello Raul! How can I help you?")
            answerLabel.text = "Hello Raul! How can I help you?"
        }else if(questionText.text!.contains("increase")){
            increaseView.isHidden = false
            recordButton.isHidden = true
            utterance = AVSpeechUtterance(string: "... I am more than happy to help!")
        }  else {
            utterance = AVSpeechUtterance(string: "... That is above my pay grade")
            answerLabel.text = "That is above my pay grade"
        }
        
        utterance.volume = 1;
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    
    @IBAction func recordButton(_ sender: Any) {
        answerLabel.text = ""
        if audioEngine.isRunning {
            print(questionText.text)
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("Start Recording", for: .normal)
            
            print(questionText.text)
            
            taxfree()
            
            
        } else {
            startRecording()
            recordButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func startRecording() {

        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record, mode: AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer!.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.questionText.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        questionText.text = "Say something, I'm listening!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
        } else {
            recordButton.isEnabled = false
        }
    }
}
