//
//  BookTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 15/02/24.
//

import XCTest

final class BookTests: XCTestCase {

    func testReadingBookAddsToLibrary() {
        // Given
        let bookToBuy = "Great Expectations"
        var user = UserBook()
        // When
        user.buy(bookToBuy)
        // Then
        XCTAssertTrue(user.owns(bookToBuy))
    }

}
