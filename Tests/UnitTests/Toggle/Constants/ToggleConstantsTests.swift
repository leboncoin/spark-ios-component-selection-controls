//
//  ToggleSubviewTypeTests.swift
//  SparkSelectionControlsTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkSelectionControls

final class ToggleConstantsTests: XCTestCase {

    // MARK: - ToggleConstants Tests

    func test_animationDuration() {
        XCTAssertEqual(
            ToggleConstants.animationDuration,
            0.2
        )
    }

    func test_toggleDotImagePadding() {
        XCTAssertEqual(
            ToggleConstants.toggleDotImagePadding,
            5
        )
    }

    // MARK: - ToggleSizes Tests

    func test_toggleSizes_width() {
        XCTAssertEqual(
            ToggleConstants.Sizes.width,
            56
        )
    }

    func test_toggleSizes_height() {
        XCTAssertEqual(
            ToggleConstants.Sizes.height,
            32
        )
    }

    func test_toggleSizes_dotSize() {
        XCTAssertEqual(
            ToggleConstants.Sizes.dotSize,
            ToggleConstants.Sizes.height
        )
    }

    func test_toggleSizes_dotPressedSize() {
        XCTAssertEqual(
            ToggleConstants.Sizes.dotPressedSize,
            ToggleConstants.Sizes.width * 0.75
        )
    }

    func test_toggleSizes_dotIncreasePressedSize() {
        XCTAssertEqual(
            ToggleConstants.Sizes.dotIncreasePressedSize,
            10
        )
    }

    func test_toggleSizes_padding() {
        XCTAssertEqual(
            ToggleConstants.Sizes.padding,
            4
        )
    }

    func test_toggleSizes_dotIconSize() {
        XCTAssertEqual(
            ToggleConstants.Sizes.dotIconSize,
            14
        )
    }

    func test_toggleSizes_hoverPadding() {
        XCTAssertEqual(
            ToggleConstants.Sizes.hoverPadding,
            4
        )
    }
}
