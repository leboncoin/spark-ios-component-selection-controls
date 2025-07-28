//
//  ToggleGetContentRadiusUseCase.swift
//  SparkSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming
import SwiftUI

// sourcery: AutoMockable, AutoMockTest
protocol ToggleGetContentRadiusUseCaseable {
    // sourcery: theme = "Identical"
    func execute(theme: Theme) -> CGFloat
}

final class ToggleGetContentRadiusUseCase: ToggleGetContentRadiusUseCaseable {

    // MARK: - Methods

    func execute(theme: Theme) -> CGFloat {
        theme.border.radius.full
    }
}
