//
//  CommonGetAnimationTypeUseCaseTests.swift
//  SparkComponentSelectionControlsTests
//
//  Created by robin.lemaire on 10/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
@testable import SparkComponentSelectionControls
@_spi(SI_SPI) import SparkCommon

final class CommonGetAnimationTypeUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_whenAnimatedAndNotReduceMotion_returnsAnimated() {
        // GIVEN
        let useCase = CommonGetAnimationTypeUseCase()

        // WHEN
        let result = useCase.execute(isOnAnimated: true, isReduceMotionEnabled: false)

        // THEN
        XCTAssertEqual(result, .animated(duration: CommonConstants.animationDuration))
    }

    func test_execute_whenNotAnimatedOrReduceMotion_returnsUnanimated() {
        // GIVEN
        let useCase = CommonGetAnimationTypeUseCase()

        // WHEN
        let result1 = useCase.execute(isOnAnimated: false, isReduceMotionEnabled: false)
        let result2 = useCase.execute(isOnAnimated: true, isReduceMotionEnabled: true)

        // THEN
        XCTAssertEqual(result1, .unanimated)
        XCTAssertEqual(result2, .unanimated)
    }
}
