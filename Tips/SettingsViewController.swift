//
//  SettingsViewController.swift
//  Tips
//
//  Created by Jim Liu on 1/7/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var defaultPercentagePicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let settingsManager = SettingsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        currencyPicker.delegate = self
        currencyPicker.selectRow(settingsManager.getDefaultCurrencyIndex(), inComponent: 0, animated: false)
        
        defaultPercentagePicker.delegate = self
        defaultPercentagePicker.selectRow(settingsManager.getDefaultTipPercentageIndex(), inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == currencyPicker {
            return settingsManager.currencies.count
        } else {
            return settingsManager.tipPecentages.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView == currencyPicker {
            return settingsManager.currencies[row]
        } else {
            return String(format:"$%.2f", settingsManager.tipPecentages[row])
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //println("selecte \(settingsManager.currencies[row])")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if sender as UIBarButtonItem == saveButton {
            settingsManager.saveDefaultCurrencyIndex(currencyPicker.selectedRowInComponent(0))
        }
    }
    

}
