//
//  ToggleGetColorUseCase.swift
//  SparkSelectionControls
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol ToggleGetColorsUseCaseable {
    // sourcery: theme = "Identical"
    func executeStatic(theme: Theme) -> ToggleStaticColors
    // sourcery: theme = "Identical"
    func executeDynamic(theme: Theme, isOn: Bool) -> ToggleDynamicColors
}

struct ToggleGetColorsUseCase: ToggleGetColorsUseCaseable {

    // MARK: - Methods

    func executeStatic(theme: Theme) -> ToggleStaticColors {
        let colors = theme.colors
        return .init(
            dotBackgroundColor: theme.colors.base.surface,
            textForegroundColor: theme.colors.base.onSurface,
            hoverColor: colors.basic.basicContainer
        )
    }

    func executeDynamic(theme: Theme, isOn: Bool) -> ToggleDynamicColors {
        let color = theme.colors.basic.basic
        return .init(
            backgroundColors: isOn ? color : color.opacity(theme.dims.dim3),
            dotForegroundColors: isOn ? color : color.opacity(theme.dims.dim2)
        )
    }
}
