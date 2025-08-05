//
//  CommonGetDimUseCase.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol CommonGetDimUseCaseable {
    // sourcery: theme = "Identical"
    func execute(theme: Theme, isEnabled: Bool) -> CGFloat
}

final class CommonGetDimUseCase: CommonGetDimUseCaseable {

    // MARK: - Methods

    func execute(theme: Theme, isEnabled: Bool) -> CGFloat {
        return isEnabled ? theme.dims.none : theme.dims.dim3
    }
}
