//
//  ToggleGetTitleFontUseCaseTests.swift
//  SparkSelectionControlsTests
//
//  Created by robin.lemaire on 10/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkSelectionControls
@_spi(SI_SPI) import SparkThemingTesting

final class ToggleGetTitleFontUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_executeUI_returnsUIFontFromTheme() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let useCase = ToggleGetTitleFontUseCase()

        // WHEN
        let result = useCase.executeUI(theme: theme)

        // THEN
        XCTAssertEqual(result, theme.typography.body1.uiFont)
    }

    func test_execute_returnsFontFromTheme() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let useCase = ToggleGetTitleFontUseCase()

        // WHEN
        let result = useCase.execute(theme: theme)

        // THEN
        XCTAssertEqual(result, theme.typography.body1.font)
    }
}
