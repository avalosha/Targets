//
//  LifecycleTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 13/02/24.
//

import XCTest

final class LifecycleTests: XCTestCase {
    
    override class func setUp() {
        print("In class setUp.")
    }
    
    override class func tearDown() {
        print("In class teardown")
    }
    
    override func setUp() {
        print("In setUp.")
    }
    
    override func tearDown() {
        print("In teardown")
    }
    
    func testExample() {
        print("Starting test")
        
        addTeardownBlock {
            print("In first teardown block")
        }
        
        print("In middle test")
        
        addTeardownBlock {
            print("In second teardown block")
        }
        
        print("Finishing test")
    }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
