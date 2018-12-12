//
//  IGWebViewViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-04.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit

class IGWebViewViewController: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
scroller.contentSize = CGSize(width: 400, height: 1200)
        //        self.scrollview.contentSize = CGSize(width: screenWidth, height: 1200)
    }
}
