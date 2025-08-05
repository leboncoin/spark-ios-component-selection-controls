//
//  CommonGetSpacingUseCase.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming
import SwiftUI

// sourcery: AutoMockable, AutoMockTest
protocol CommonGetSpacingUseCaseable {
    // sourcery: theme = "Identical"
    func execute(theme: Theme) -> CGFloat
}

final class CommonGetSpacingUseCase: CommonGetSpacingUseCaseable {

    // MARK: - Methods

    func execute(theme: Theme) -> CGFloat {
        return theme.layout.spacing.medium
    }
}
