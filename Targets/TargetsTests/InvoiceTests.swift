//
//  InvoiceTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 08/02/24.
//

import XCTest
@testable import Targets

final class InvoiceTests: XCTestCase {
    
    private var sut: Invoice!
    private let testFee = Fee(category: TestConstants.someFeeCategory, amount: TestConstants.someDouble)
    
    override func setUp() {
        sut = Invoice()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testFees_isEmpty() {
        // Then
        XCTAssertTrue(sut.fees.isEmpty)
    }
    
    func testAddFee_newFeeIsTheOnlyFeeInFees() {
        // When
        sut.addFee(testFee)
        // Then
        XCTAssertEqual(sut.fees.count, 1)
        XCTAssertTrue(sut.fees.contains(testFee))
    }
    
    func testAddFee_oneFeeAdded_newFeeAddedToFees() {
        // Given
        sut.addFee(testFee)
        let secondTestFee = Fee(category: TestConstants.someOtherFeeCategory, amount: TestConstants.someOtherDouble)
        // When
        sut.addFee(secondTestFee)
        // Then
        XCTAssertEqual(sut.fees.count, 2)
        XCTAssertTrue(sut.fees.contains(testFee))
        XCTAssertTrue(sut.fees.contains(secondTestFee))
    }
    
    func testTotalPayableAmount_hasSumOfAmountsOfFeesAddedToInvoice() {
        // Given
        let testAmount = 100.0
        let secondTestAmount = 150.0
        // When
        sut.addFee(Fee(category: TestConstants.someFeeCategory, amount: testAmount))
        sut.addFee(Fee(category: TestConstants.someFeeCategory, amount: secondTestAmount))
        // Then
        XCTAssertEqual(sut.totalPayableAmount, testAmount + secondTestAmount)
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
