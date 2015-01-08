//
//  ViewController.swift
//  Tips
//
//  Created by Jim Liu on 1/7/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSeg: UISegmentedControl!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    @IBOutlet weak var splitSwitch: UISwitch!
    @IBOutlet weak var eachLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupField: UITextField!
    @IBOutlet weak var eachDueLabel: UILabel!
    
    let settingsManager = SettingsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.text = ""
        billField.delegate = self
        
        tipLabel.text = formatAmount(0.0);
        totalLabel.text = formatAmount(0.0);
        currencyLabel.text = settingsManager.getDefaultCurrency()
        
        tipSeg.selectedSegmentIndex = settingsManager.getDefaultTipPercentageIndex()
        
        hideSplitUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditing(sender: AnyObject) {
        refreshNumbers()
    }

    
    @IBAction func onGroupChanged(sender: AnyObject) {
        refreshEach()
    }

    @IBAction func onTapped(sender: AnyObject) {
        billField.endEditing(true)
        groupField.endEditing(true)
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        //check if default currency changed
        if currencyLabel.text != settingsManager.getDefaultCurrency() {
            currencyLabel.text = settingsManager.getDefaultCurrency()
            
            refreshNumbers()
        }
    }
    
    @IBAction func onCheck(sender: AnyObject) {
        if splitSwitch.on {
           showSplitUI()
        } else {
            hideSplitUI()
        }
    }
    
    func refreshNumbers() {
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue;
        var tipAmount = billAmount * settingsManager.tipPecentages[tipSeg.selectedSegmentIndex];
    
        tipLabel.text = formatAmount(tipAmount);
        totalLabel.text = formatAmount(billAmount + tipAmount)
        if splitSwitch.on {
            eachDueLabel.text = formatAmount((billAmount + tipAmount) / Double(groupField.text.toInt()!))
        }
    }
    
    func refreshEach() {
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue;
        var tipAmount = billAmount * settingsManager.tipPecentages[tipSeg.selectedSegmentIndex];
        
        if splitSwitch.on {
            eachDueLabel.text = formatAmount((billAmount + tipAmount) / Double(groupField.text.toInt()!))
        }
    }
    
    func hideSplitUI() {
        groupLabel.hidden = true
        groupField.hidden = true
        eachLabel.hidden = true
        eachDueLabel.hidden = true
        
        if nil == groupField.text.toInt() {
            eachDueLabel.text = totalLabel.text
        }
    }
    
    func showSplitUI() {
        groupLabel.hidden = false
        groupField.hidden = false
        eachLabel.hidden = false
        eachDueLabel.hidden = false
    }
    
    func formatAmount(amount: Double) -> String {
        return String(format:"\(settingsManager.getDefaultCurrency())%.2f", amount);
    }
    
    //Textfield delegates to only allow 0-9 and .
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            return true
        case ".":
            let array = Array(textField.text)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount++
                }
            }
            
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string)
            if array.count == 0 {
                return true
            }
            return false
        }
    }
}

