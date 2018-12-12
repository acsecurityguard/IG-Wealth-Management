//
//  processingViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-11.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class processingViewController: UIViewController {
  
    
    @IBOutlet weak var checkmark: UILabel!
    @IBOutlet weak var labelproc: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var utterance = AVSpeechUtterance(string: "... Your estimated life time contributions in this account at I.G Wealth Management after this one time contribution will be 52800 dollars ")
        utterance.volume = 1;
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        checkmark.isHidden = true
        finish()
    }
    func finish(){
        sleep(2)
       
        checkmark.isHidden = false
        
    }
    
}
