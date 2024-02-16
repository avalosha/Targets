//
//  FeeTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 07/02/24.
//

import XCTest
@testable import Targets

final class FeeTests: XCTestCase {
    
    private var sut: Fee!
    
    override func setUp() {
//        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
//        super.tearDown()
        sut = nil
    }
    
    func testCategory_hasValueEnrollmentPassedInThroughIntitializer() {
        // Given
        let testCategory = Fee.Category.enrollment
        // When
        sut = Fee(category: testCategory, amount: TestConstants.someDouble)
        // Then
        XCTAssertEqual(sut.category, testCategory)
        
        addTeardownBlock {
            //
        }
    }
    
    func testCategory_hasValueCourseWithTitlePassedInThroughInitializer() {
        // Given
        let testCategory = Fee.Category.course(TestConstants.someString)
        // When
        sut = Fee(category: testCategory, amount: TestConstants.someDouble)
        // Then
        XCTAssertEqual(sut.category, testCategory)
        
        addTeardownBlock {
            //
        }
    }
    
    func testAmount_hasValuePassedInThroughInitializer() {
        // Given
        let testAmount = 100.0
        // When
        sut = Fee(category: TestConstants.someFeeCategory, amount: testAmount)
        // Then
        XCTAssertEqual(sut.amount, testAmount)
    }

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        try super.tearDownWithError()
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
