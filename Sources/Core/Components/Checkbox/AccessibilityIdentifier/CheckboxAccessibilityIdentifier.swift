//
//  CheckboxAccessibilityIdentifier.swift
//  SparkComponentSelectionControlsTests
//
//  Created by michael.zimmermann on 14.04.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

// TODO: Tests

public enum CheckboxAccessibilityIdentifier {

    // MARK: - Properties

    public static let view = "spark-checkbox"
    public static let group = "spark-checkbox-group"

    /// The radio group title accessibility identifier.
    public static let checkboxGroupTitle = "spark-radio-group-title"

    /// The radio button text label accessibility identifier.
    public static let checkboxTextLabel = "spark-radio-button-text-label"

    public static func checkboxItem<ID: CustomStringConvertible>(id: ID) -> String {
        return "\(self.view)-\(id)"
    }
}
