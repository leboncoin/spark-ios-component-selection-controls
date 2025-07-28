//
//  ToggleGetContentRadiusUseCaseTests.swift
//  SparkSelectionControlsTests
//
//  Created by robin.lemaire on 10/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkSelectionControls
@_spi(SI_SPI) import SparkThemingTesting

final class ToggleGetContentRadiusUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_returnsFullRadius() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let useCase = ToggleGetContentRadiusUseCase()

        // WHEN
        let result = useCase.execute(theme: theme)

        // THEN
        XCTAssertEqual(result, theme.border.radius.full)
    }
}
