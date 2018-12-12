//
//  FirstViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-04.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit
import WebKit

class TrendingViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var trendingWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://sso.investorsgroup.com/isam/sps/auth")
        let myRequest = URLRequest(url: myURL!)
        trendingWebView.load(myRequest)
    }
}


