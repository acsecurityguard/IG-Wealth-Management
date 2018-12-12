//
//  IncreaseViewController.swift
//  IQ Wealth Management
//
//  Created by Raul Rambo on 2018-12-11.
//  Copyright © 2018 Raul Rambo. All rights reserved.
//

import UIKit

class IncreaseViewController: UITabBarController, UIPickerViewDelegate {

    
    var gradePicker: UIPickerView!
    @IBOutlet weak var picked: UILabel!
    let gradePickerValues = ["5. Klasse", "6. Klasse", "7. Klasse"]
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return gradePickerValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return gradePickerValues[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        picked.text = gradePickerValues[row]
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        gradePicker = UIPickerView()
//        
//        gradePicker.dataSource = self as! UIPickerViewDataSource
//        gradePicker.delegate = self
//        
//        //picked.inputView = gradePicker
//        picked.text = gradePickerValues[0]

        // Do any additional setup after loading the view.
    }
    

}
