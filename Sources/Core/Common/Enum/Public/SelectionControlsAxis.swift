//
//  SelectionControlConstants.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation

// TODO: Tests

/// Enum describing axis options for selection controls.
@frozen
public enum SelectionControlsAxis: String, CaseIterable {
    /// Horizontal layout.
    case horizontal
    /// Vertical layout.
    case vertical

    // MARK: - Properties

    static var `default` = Self.vertical
}
