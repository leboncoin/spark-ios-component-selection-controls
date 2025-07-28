//
//  ToggleGetSpacingUseCase.swift
//  SparkSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming
import SwiftUI

// sourcery: AutoMockable, AutoMockTest
protocol ToggleGetSpacingUseCaseable {
    // sourcery: theme = "Identical"
    func execute(theme: Theme) -> CGFloat
}

final class ToggleGetSpacingUseCase: ToggleGetSpacingUseCaseable {

    // MARK: - Methods

    func execute(theme: Theme) -> CGFloat {
        return theme.layout.spacing.medium
    }
}
