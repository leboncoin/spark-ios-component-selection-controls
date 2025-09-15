//
//  SelectionControlsIntentTests.swift
//  SparkComponentSelectionControlsTests
//
//  Created by robin.lemaire on 28/08/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentSelectionControls

final class SelectionControlsIntentTests: XCTestCase {

    // MARK: - Properties Tests

    func test_default_shouldReturnBasic() {
        // GIVEN / WHEN
        let result = SelectionControlsIntent.default

        // THEN
        XCTAssertEqual(result, .basic)
    }
}
