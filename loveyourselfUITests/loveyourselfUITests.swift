//
//  loveyourselfUITests.swift
//  loveyourselfUITests
//
//  Created by David Fontenot on 5/27/16.
//  Copyright © 2016 David Fontenot. All rights reserved.
//

import XCTest

class loveyourselfUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        snapshot("0Launch")
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        let iLoveMyselfButton = XCUIApplication().buttons["I Love Myself"]
        iLoveMyselfButton.tap()
        iLoveMyselfButton.tap()
        iLoveMyselfButton.tap()
        iLoveMyselfButton.tap()
        
        
        //sleep(3)
        
        var GlobalMainQueue: dispatch_queue_t {
            return dispatch_get_main_queue()
        }

        let delayInSeconds: Double = 2.0
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
                                    Int64(delayInSeconds * Double(NSEC_PER_SEC))) // 1
        
        dispatch_after(popTime, GlobalMainQueue) { // 2
            snapshot("floating-hearts")
        }
        
        let delayInSeconds2: Double = 3.0
        let popTime2 = dispatch_time(DISPATCH_TIME_NOW,
                                    Int64(delayInSeconds2 * Double(NSEC_PER_SEC))) // 1
        
        dispatch_after(popTime2, GlobalMainQueue) { // 2
            snapshot("floating-hearts2")
        }
        
        let delayInSeconds3: Double = 4.0
        let popTime3 = dispatch_time(DISPATCH_TIME_NOW,
                                     Int64(delayInSeconds3 * Double(NSEC_PER_SEC))) // 1
        
        dispatch_after(popTime3, GlobalMainQueue) { // 2
            snapshot("floating-hearts3")
        }
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
