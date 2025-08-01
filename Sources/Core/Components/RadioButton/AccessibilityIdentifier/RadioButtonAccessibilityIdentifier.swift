//
//  RadioButtonAccessibilityIdentifier.swift
//  SparkComponentSelectionControlsTests
//
//  Created by michael.zimmermann on 14.04.23.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

// TODO: Tests

public enum RadioButtonAccessibilityIdentifier {

    // MARK: - Properties

    public static let view = "spark-radio-button"
    public static let group = "spark-radio-group"

    /// The radio group title accessibility identifier.
    public static let radioGroupTitle = "spark-radio-button-title"

    /// The radio button text label accessibility identifier.
    public static let radioButtonTextLabel = "spark-radio-button-text-label"

    public static func radioButtonItem<ID: CustomStringConvertible>(id: ID) -> String {
        return "\(self.view)-\(id)"
    }
}
