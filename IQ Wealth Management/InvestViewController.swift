//
//  InvestViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-06.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit
import WebKit

class InvestViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var trendingview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://www.investorsgroup.com/en/articles")
        let myRequest = URLRequest(url: myURL!)
        trendingview.load(myRequest)
    }
    
}
