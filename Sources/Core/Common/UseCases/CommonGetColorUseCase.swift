//
//  CommonGetColorUseCase.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 30/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SparkTheming

// TODO: Tester

// sourcery: AutoMockable, AutoMockTest
protocol CommonGetColorUseCaseable {
    // sourcery: theme = "Identical"
    func executeContent(theme: Theme, intent: SelectionControlsIntent) -> any ColorToken
    // sourcery: theme = "Identical"
    func executeBorder(theme: Theme, intent: SelectionControlsIntent, isSelected: Bool) -> any ColorToken
    // sourcery: theme = "Identical"
    func executeHover(theme: Theme, intent: SelectionControlsIntent) -> any ColorToken
}

struct CommonGetColorUseCase: CommonGetColorUseCaseable {

    // MARK: - Methods

    func executeContent(
        theme: Theme,
        intent: SelectionControlsIntent
    ) -> any ColorToken {
        return self.executeState(
            theme: theme,
            intent: intent
        )
    }

    func executeBorder(
        theme: Theme,
        intent: SelectionControlsIntent,
        isSelected: Bool
    ) -> any ColorToken {
        let state = self.executeState(
            theme: theme,
            intent: intent
        )

        return switch intent {
        case .error: state
        case .basic: isSelected ? state : theme.colors.base.outline
        }
    }

    func executeHover(
        theme: Theme,
        intent: SelectionControlsIntent
    ) -> any ColorToken {
        return switch intent {
        case .error: theme.colors.feedback.errorContainer
        case .basic: theme.colors.basic.basicContainer
        }
    }

    // MARK: - Private Properties

    func executeState(
        theme: Theme,
        intent: SelectionControlsIntent
    ) -> any ColorToken {
        return switch intent {
        case .error: theme.colors.feedback.error
        case .basic: theme.colors.basic.basic
        }
    }
}
