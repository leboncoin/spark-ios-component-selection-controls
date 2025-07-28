//
//  ToggleGetShowHiddenEmptyLabelUseCaseTests.swift
//  SparkSelectionControlsTests
//
//  Created by robin.lemaire on 10/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkSelectionControls

final class ToggleGetShowHiddenEmptyLabelUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_whenIsCustomLabel_returnsLeft() {
        // GIVEN
        let useCase = ToggleGetShowHiddenEmptyLabelUseCase()

        // WHEN
        let result = useCase.execute(isCustomLabel: true)

        // THEN
        XCTAssertTrue(result)
    }

    func test_execute_whenIsNotCustomLabel_returnsRight() {
        // GIVEN
        let useCase = ToggleGetShowHiddenEmptyLabelUseCase()

        // WHEN
        let result = useCase.execute(isCustomLabel: false)

        // THEN
        XCTAssertFalse(result)
    }
}
