//
//  ToggleStaticColorsTests.swift
//  SparkComponentSelectionControlsSnapshotTests
//
//  Created by robin.lemaire on 28/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentSelectionControls
@_spi(SI_SPI) @testable import SparkTheming

final class ToggleStaticColorsTests: XCTestCase {

    // MARK: - Tests

    func test_defaultValues() {
        let colors = ToggleStaticColors()
        XCTAssertTrue(colors.dotBackgroundColor.equals(ColorTokenClear()))
        XCTAssertTrue(colors.textForegroundColor.equals(ColorTokenClear()))
        XCTAssertTrue(colors.hoverColor.equals(ColorTokenClear()))
    }
}
