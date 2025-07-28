//
//  ToggleGetShowHiddenEmptyLabelUseCase.swift
//  SparkSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation

// sourcery: AutoMockable, AutoMockTest
protocol ToggleGetShowHiddenEmptyLabelUseCaseable {
    func execute(isCustomLabel: Bool) -> Bool
}

final class ToggleGetShowHiddenEmptyLabelUseCase: ToggleGetShowHiddenEmptyLabelUseCaseable {

    // MARK: - Methods

    func execute(isCustomLabel: Bool) -> Bool {
        return isCustomLabel
    }
}
