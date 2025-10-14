//
//  SparkRadioGroup.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// A Spark control that radio group between selected or unselected states.
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectedID: Int?
///
///     var body: some View {
///         SparkRadioGroup(
///             theme: self.theme,
///             selectedID: self.$selectedID,
///             items: [
///                 RadioGroupItem(
///                     id: 1,
///                     title: "My first item"
///                 ),
///                 RadioGroupItem(
///                     id: 2,
///                     title: "My last item"
///                 )
///             ]
///         )
///     }
/// }
/// ```
/// ![Radio group rendering with a Label.](radioGroup.png)
public struct SparkRadioGroup<ID, Label>: View where ID: SelectionControlsGroupID, Label: View {

    // MARK: - Properties

    private let theme: any Theme

    @Binding private var selectedID: ID?
    private let items: [RadioGroupItem<ID, Label>]

    @Environment(\.radioGroupAxis) private var axis

    // MARK: - Initialization

    /// Creates a Spark radio group with items.
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - selectedID: A binding to a property that indicates whether the radio button is selected or not. The value is optional.
    ///   - items: The items (array of ``RadioGroupItem``) of the group.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectedID = 1
    ///
    ///     var body: some View {
    ///         SparkRadioGroup(
    ///             theme: self.theme,
    ///             selectedID: self.$selectedID,
    ///             items: [
    ///                 RadioGroupItem(
    ///                     id: 1,
    ///                     title: "My first item"
    ///                 ),
    ///                 RadioGroupItem(
    ///                     id: 2,
    ///                     title: "My last item"
    ///                 )
    ///             ]
    ///         )
    ///     }
    /// }     
    /// ```
    ///
    /// ![Radio Group rendering.](radioGroup.png)
    public init(
        theme: any Theme,
        selectedID: Binding<ID?>,
        items: [RadioGroupItem<ID, Label>]
    ) {
        self.theme = theme
        self._selectedID = selectedID
        self.items = items
    }

    // MARK: - View

    public var body: some View {
        CommonGroup(theme: self.theme) {
            ForEach(self.items, id: \.id) { item in
                SparkRadioButton(
                    theme: self.theme,
                    isSelected: Binding(
                        get: {
                            self.selectedID == item.id
                        },
                        set: { value in
                            self.selectedID = value ? item.id : nil
                        }
                    ),
                    label: item.label
                )
                .disabled(!item.isEnabled)
                .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.radioButtonItem(id: item.id))
            }
        }
        .axis(self.axis)
        .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.group)
    }
}
