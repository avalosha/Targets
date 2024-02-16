//
//  AppTests.swift
//  TargetsTests
//
//  Created by Sferea-Lider on 13/02/24.
//

import XCTest

final class AppTests: XCTestCase {

    func testUserCantBuyUnreleasedApp() {
        struct UnreleasedAppStub: AppProtocol {
            var price: Decimal = 0
            var minimumAge: Int = 0
            var isReleased: Bool = false
            
            func canBePurchased(by user: UserProtocol) -> Bool {
                return false
            }
            
        }
        
        // Given
        var sut = UserModel(funds: 100, age: 21, apps: [])
        let app = UnreleasedAppStub()
        type(of: app).printTerms()
        // When
        let wasBought = sut.buy(app)
        // Then
        XCTAssertFalse(wasBought)
    }
}
