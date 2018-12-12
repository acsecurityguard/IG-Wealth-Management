//
//  LogInViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-10.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit
import WebKit
import LocalAuthentication

class LogInViewController: UIViewController {

    @IBOutlet weak var log1: UILabel!
    @IBOutlet weak var log2: UITextField!
    @IBOutlet weak var log3: UILabel!
    @IBOutlet weak var log4: UITextField!
    @IBOutlet weak var log5: UIButton!
    @IBOutlet weak var welcomeView: UIView!
    
    @IBOutlet weak var label2: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBAction func typeCredentials(_ sender: Any) {
        self.log1.isHidden = false
        self.log3.isHidden = false
        self.log4.isHidden = false
        self.log2.isHidden = false
        self.log5.isHidden = false
        self.label2.isHidden = true
        self.label1.isHidden = true
        
    }
    
    
    func authenticate() {
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error:nil)
        {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "something", reply: { ( wasCorrect, error ) in
                if wasCorrect
                {
                    self.performSegue(withIdentifier: "homeApp", sender: self)
//                    DispatchQueue.main.async { self.welcomeView.isHidden = true
//                    }
                    print("correct")
                }
                else
                {
                    print("incorrect")
                }
            } )
        }
        else
        {
            print("something else")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.log1.isHidden = true
        self.log3.isHidden = true
        self.log4.isHidden = true
        self.log2.isHidden = true
        self.log5.isHidden = true
        authenticate()
        
    }
    
    
    
    
}

