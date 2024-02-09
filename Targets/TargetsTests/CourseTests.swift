//
//  CourseTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 08/02/24.
//

import XCTest
@testable import Targets

final class CourseTests: XCTestCase {
    
    private var sut: Course!
    
    override func tearDown() {
        sut = nil
    }
    
    func testTitle_hasValuePassedInThroughInitializer() {
        // Given
        let testTitle = "Course title"
        // When
        sut = Course(title: testTitle, credits: TestConstants.someDouble)
        // Then
        XCTAssertEqual(sut.title, testTitle)
    }
    
    func testCredits_hasValuePassedInThroughInitializer() {
        // Given
        let testCredits = 5.0
        // When
        sut = Course(title: TestConstants.someString, credits: testCredits)
        // Then
        XCTAssertEqual(sut.credits, testCredits)
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
