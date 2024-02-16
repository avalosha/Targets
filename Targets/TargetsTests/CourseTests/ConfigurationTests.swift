//
//  ConfigurationTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 09/02/24.
//

import XCTest
@testable import Targets

final class ConfigurationTests: XCTestCase {
    
    typealias sutType = Configuration
    
    func testEnrollmentFeeAmount_hasDoubleValue200() {
        XCTAssertEqual(sutType.enrollmentFeeAmount, 200.0)
    }
    
    func testEnrolledStudentCourseCreditFeeAmount_hasDoubleValue50() {
        XCTAssertEqual(sutType.enrolledSudentCourseCreditFeeAmount, 50.0)
    }
    
    func testCasualStudentCourseCreditFeeAmount_hasDoubleValue75() {
        XCTAssertEqual(sutType.casualStudentCourseCreditFeeAmount, 75.0)
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
