//
//  TipsTests.swift
//  TipsTests
//
//  Created by Jim Liu on 1/8/15.
//  Copyright (c) 2015 Jim Liu. All rights reserved.
//

import Tips
import UIKit
import XCTest

class SettingsManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSettingsManager() {
        let settingsManager = SettingsManager.sharedInstance
        
        settingsManager.saveDefaultCurrencyIndex(0)
        XCTAssertEqual(0, settingsManager.getDefaultCurrencyIndex())
        
        settingsManager.saveDefaultTipPercentageIndex(1)
        XCTAssertEqual(1, settingsManager.getDefaultTipPercentageIndex())
        
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
