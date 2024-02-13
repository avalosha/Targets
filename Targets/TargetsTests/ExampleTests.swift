//
//  ExampleTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 09/02/24.
//

import XCTest
@testable import Targets

final class ExampleTests: XCTestCase {
    
    private var sut: User!
    private var numberStack = Stack<Int>()
    
    override func tearDown() {
        sut = nil
    }
    
    func testUser_userHaveID() {
        // Given
        let id = "sferea2"
        // When
        sut = User(id: id)
        sut.identify()
        // Then
        XCTAssertEqual(sut.id, id)
    }
    
    func testStack_doPush() {
        // Given
        numberStack.push(20)
        numberStack.push(10)
        // When
        numberStack.count()
        let pop = numberStack.pop()
        numberStack.count()
        // Then
        XCTAssertEqual(pop, 10)
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