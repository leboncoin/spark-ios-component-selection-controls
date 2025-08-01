//
//  CheckboxGroupItem.swift
//  SparkComponentSelectionControlsTests
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import Foundation
import SwiftUI

/// A simple struct for defining checkbox group using the ``CheckBoxGroupView``.
public struct CheckboxGroupItem<ID, Label>: Identifiable where ID: Equatable & Hashable, Label: View {

    // MARK: - Properties

    /// The identifier of the checkbox.
    public let id: ID

    /// The label of the checkbox.
    internal let label: () -> Label

    /// The current control state of the checkbox.
    public var isEnabled: Bool

    // MARK: - Initialization

    /// Creates a checkbox group item from a localized string key.
    ///
    /// - Parameters:
    ///  - id: A unique ID bound to a generic type which has the constraints that it need be ``Equatable`` & ``Hashable``
    ///  - titleKey: The key for the checkbox item's localized title, that describes the purpose of the checkbox.
    ///  - isEnabled: The current control state of the checkbox. Default is **true**.
    public init(
        id: ID,
        titleKey: LocalizedStringKey,
        isEnabled: Bool = true
    ) where Label == Text {
        self.id = id
        self.label = { Text(titleKey) }
        self.isEnabled = isEnabled
    }

    /// Creates a checkbox group item from a string.
    ///
    /// - Parameters:
    ///  - id: A unique ID bound to a generic type which has the constraints that it need be ``Equatable`` & ``Hashable``
    ///  - title: The key for the checkbox item's title, that describes the purpose of the checkbox.
    ///  - isEnabled: The current control state of the checkbox. Default is **true**.
    public init(
        id: ID,
        title: String,
        isEnabled: Bool = true
    ) where Label == Text {
        self.id = id
        self.label = { Text(title) }
        self.isEnabled = isEnabled
    }

    /// Creates a checkbox group item from a label.
    ///
    /// - Parameters:
    ///  - id: A unique ID bound to a generic type which has the constraints that it need be ``Equatable`` & ``Hashable``
    ///  - label: A view that describes the purpose of the toggle.
    ///  - isEnabled: The current control state of the checkbox. Default is **true**.
    public init(
        id: ID,
        isEnabled: Bool = true,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.id = id
        self.label = label
        self.isEnabled = isEnabled
    }
}
