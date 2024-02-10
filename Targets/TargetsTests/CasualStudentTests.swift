//
//  CasualStudentTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 09/02/24.
//

import XCTest
@testable import Targets

final class CasualStudentTests: XCTestCase {
    
    private let testCourse = Course(title: TestConstants.someString, credits: TestConstants.someDouble)
    private let secondTestCourse = Course(title: TestConstants.someOtherString, credits: TestConstants.someOtherDouble)
    
    private var sut: CasualStudent!
    
    override func setUp() {
        sut = CasualStudent()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testCourses_isEmpty() {
        XCTAssertTrue(sut.courses.isEmpty)
    }
    
    func testTakeCourse_newCourseIsTheOnlyCourseInCourses() {
        // When
        sut.takeCourse(testCourse)
        // Then
        XCTAssertEqual(sut.courses.count, 1)
        XCTAssertTrue(sut.courses.contains(testCourse))
    }
    
    func testTakeCourse_oneCourseTaken_newCourseAddedToCourses() {
        // Given
        sut.takeCourse(testCourse)
        // When
        sut.takeCourse(secondTestCourse)
        // Then
        XCTAssertEqual(sut.courses.count, 2)
        XCTAssertTrue(sut.courses.contains(testCourse))
        XCTAssertTrue(sut.courses.contains(secondTestCourse))
    }
    
    func testTakeCourseWithDuplicateCourse_oneCourseTaken_newCourseNotAddedToCourses() {
        // Given
        sut.takeCourse(testCourse)
        // When
        sut.takeCourse(testCourse)
        // Then
        XCTAssertEqual(sut.courses.count, 1)
        XCTAssertTrue(sut.courses.contains(testCourse))
    }
    
    func testCompleteCourse_oneCourseTaken_coursesIsEmpty() {
        // Given
        sut.takeCourse(testCourse)
        // When
        sut.completeCourse(testCourse)
        // Then
        XCTAssertTrue(sut.courses.isEmpty)
    }
    
    func testCompleteCourse_twoCoursesTaken_coursesHasOnlyCourseNotCompleted() {
        // Given
        sut.takeCourse(testCourse)
        sut.takeCourse(secondTestCourse)
        // When
        sut.completeCourse(testCourse)
        // Then
        XCTAssertEqual(sut.courses.count, 1)
        XCTAssertTrue(sut.courses.contains(secondTestCourse))
    }
    
    func testGenerateInvoice_notTakingCourses_invoiceDoesNotHaveAnyFee() {
        // When
        let invoice = sut.generateInvoice()
        // Then
        XCTAssertTrue(invoice.fees.isEmpty)
    }
    
    func testGenerateInvoice_takingCourses_invoiceHasCourseFees() {
        // Given
        let testCourseCreditsArray = [1.0,2.0,3.0]
        for testCourseCredit in testCourseCreditsArray {
            let course = Course(title: TestConstants.someString, credits: testCourseCredit)
            sut.takeCourse(course)
        }
        // When
        let invoice = sut.generateInvoice()
        // Then
        XCTAssertEqual(invoice.fees.count, testCourseCreditsArray.count)
        for testCourseCredits in testCourseCreditsArray {
            let expectedCourseFee = Fee(category: .course(TestConstants.someString), amount: testCourseCredits * Configuration.casualStudentCourseCreditFeeAmount)
            XCTAssertTrue(invoice.fees.contains(expectedCourseFee))
        }
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
