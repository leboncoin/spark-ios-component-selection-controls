//
//  ToggleGetSpacingUseCaseTests.swift
//  SparkSelectionControlsTests
//
//  Created by robin.lemaire on 10/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkSelectionControls
@_spi(SI_SPI) import SparkThemingTesting

final class ToggleGetSpacingUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_returnsMediumSpacing() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let useCase = ToggleGetSpacingUseCase()

        // WHEN
        let result = useCase.execute(theme: theme)

        // THEN
        XCTAssertEqual(result, theme.layout.spacing.medium)
    }
}
