//
//  CommonGetColorUseCaseTests.swift
//  SparkComponentSelectionControlsTests
//
//  Created by robin.lemaire on 30/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentSelectionControls
@_spi(SI_SPI) import SparkThemingTesting

final class CommonGetColorUseCaseTests: XCTestCase {

    // MARK: - ExecuteContent Tests

    func test_executeContent_withBasicIntent_returnsBasicColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.basic

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeContent(
            theme: theme,
            intent: intent
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.basic.basic))
    }

    func test_executeContent_withErrorIntent_returnsErrorColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.error

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeContent(
            theme: theme,
            intent: intent
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.feedback.error))
    }

    // MARK: - ExecuteBorder Tests

    func test_executeBorder_withBasicIntentAndSelected_returnsBasicColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.basic
        let isSelected = true

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeBorder(
            theme: theme,
            intent: intent,
            isSelected: isSelected
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.basic.basic))
    }

    func test_executeBorder_withBasicIntentAndNotSelected_returnsOutlineColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.basic
        let isSelected = false

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeBorder(
            theme: theme,
            intent: intent,
            isSelected: isSelected
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.base.outline))
    }

    func test_executeBorder_withErrorIntentAndSelected_returnsErrorColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.error
        let isSelected = true

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeBorder(
            theme: theme,
            intent: intent,
            isSelected: isSelected
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.feedback.error))
    }

    func test_executeBorder_withErrorIntentAndNotSelected_returnsErrorColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.error
        let isSelected = false

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeBorder(
            theme: theme,
            intent: intent,
            isSelected: isSelected
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.feedback.error))
    }

    // MARK: - ExecuteHover Tests

    func test_executeHover_withBasicIntent_returnsBasicContainerColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.basic

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeHover(
            theme: theme,
            intent: intent
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.basic.basicContainer))
    }

    func test_executeHover_withErrorIntent_returnsErrorContainerColor() {
        // GIVEN
        let theme = ThemeGeneratedMock.mocked()
        let intent = SelectionControlsIntent.error

        let useCase = CommonGetColorUseCase()

        // WHEN
        let result = useCase.executeHover(
            theme: theme,
            intent: intent
        )

        // THEN
        XCTAssertTrue(result.equals(theme.colors.feedback.errorContainer))
    }
}
