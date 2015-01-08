//
//  SettingsManager.swift
//  Tips
//
//  Created by Jim Liu on 1/7/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

import Foundation

class SettingsManager {
    
    //supported currencies
    let currencies = ["$", "¥", "€", "£"]
    
    //supported tip percentagess
    let tipPecentages = [0.18, 0.20, 0.22];
    
    let defaultCurrencyIndexKey = "DefaultCurrencyIndex"
    let defaultTipPercentageIndexKey = "DefaultTipPercentageIndex"
    
    let defaultCurrencyIndex = 0
    let defaultTipPercentageIndex = 1
    
    //singleton
    class var sharedInstance : SettingsManager {
        struct Static {
            static let instance : SettingsManager = SettingsManager()
        }
        return Static.instance
    }
    
    func saveDefaultCurrencyIndex(currencyIndex: Int) {
       saveUserDefaultsInt(defaultCurrencyIndexKey, value: currencyIndex)
    }
    
    func saveDefaultTipPercentageIndex(tipPercentageIndex: Int) {
        saveUserDefaultsInt(defaultTipPercentageIndexKey, value: tipPercentageIndex)
    }
    
    func getDefaultCurrency() -> String {
        return currencies[getUserDefaultsInt(defaultCurrencyIndexKey)]
    }
    
    func getDefaultCurrencyIndex() -> Int {
        return getUserDefaultsInt(defaultCurrencyIndexKey)
    }
    
    func getDefaultTipPercentage() -> Double {
        return tipPecentages[getUserDefaultsInt(defaultTipPercentageIndexKey)]
    }
    
    func getDefaultTipPercentageIndex() -> Int {
        return getUserDefaultsInt(defaultTipPercentageIndexKey)
    }
    
    func saveUserDefaultsInt(key: String, value: Int) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(value, forKey: key)
        defaults.synchronize()
    }
    
    func getUserDefaultsInt(key: String) -> Int{
        var defaults = NSUserDefaults.standardUserDefaults()
        if let objectValue = defaults.objectForKey(key) {
            return objectValue.integerValue
        } else {
            if key == defaultCurrencyIndexKey {
                return defaultCurrencyIndex
            } else {
                return defaultTipPercentageIndex
            }
        }
    }
    
}