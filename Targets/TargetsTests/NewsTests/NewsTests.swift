//
//  NewsTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 15/02/24.
//

import XCTest

final class NewsTests: XCTestCase {
    
    func testNewsFetchLoadsCorrectURL() {
        // Given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloadig news stories.")
        // When
        news.fetch(using: session) {
//            XCTAssertEqual(URL(string: "https://www.apple.com/newsroom/rss-feed.rss"), session.lastURL)
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
    }
    
    func testNewsFetchCallsResume() {
        // Given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        let news = News(url: url)
        let session = URLSessionMock()
        let expectation = XCTestExpectation(description: "Downloadig news stories triggers resume().")
        // When
        news.fetch(using: session) {
            XCTAssertTrue(session.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 5)
    }

    func testNewsStoriesAreFetched() {
        // Given
        
        // When
        
        // Then
    }
}
