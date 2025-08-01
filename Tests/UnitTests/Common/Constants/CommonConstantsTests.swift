//
//  CommonConstantsTests.swift
//  SparkComponentSelectionControlsTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentSelectionControls

final class CommonConstantsTests: XCTestCase {

    // MARK: - Animation Tests

    func test_animationDuration() {
        XCTAssertEqual(
            CommonConstants.animationDuration,
            0.2
        )
    }

    // MARK: - Animation Sizes

    func test_toggleSizes_hoverPadding() {
        XCTAssertEqual(
            CommonConstants.hoverPadding,
            4
        )
    }
}
