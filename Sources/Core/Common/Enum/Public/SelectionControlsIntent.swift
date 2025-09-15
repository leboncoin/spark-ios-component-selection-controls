//
//  SelectionControlsIntent.swift
//  SparkComponentSelectionControls
//
//  Created by michael.zimmermann on 18.09.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

import Foundation

/// Enum describing intent options for selection controls.
public enum SelectionControlsIntent: String, CaseIterable {
    case basic
    case error

    // MARK: - Properties

    /// The default case. Equals to **.basic**.
    static var `default` = Self.basic
}
