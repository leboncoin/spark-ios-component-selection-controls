//
//  ToggleGetAnimationTypeUseCase.swift
//  SparkSelectionControls
//
//  Created by robin.lemaire on 07/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkCommon

// sourcery: AutoMockable, AutoMockTest
protocol ToggleGetAnimationTypeUseCaseable {
    func execute(isOnAnimated: Bool, isReduceMotionEnabled: Bool) -> UIExecuteAnimationType
}

final class ToggleGetAnimationTypeUseCase: ToggleGetAnimationTypeUseCaseable {

    // MARK: - Methods

    func execute(isOnAnimated: Bool, isReduceMotionEnabled: Bool) -> UIExecuteAnimationType {
        isOnAnimated && !isReduceMotionEnabled ? .animated(duration: ToggleConstants.animationDuration) : .unanimated
    }
}
