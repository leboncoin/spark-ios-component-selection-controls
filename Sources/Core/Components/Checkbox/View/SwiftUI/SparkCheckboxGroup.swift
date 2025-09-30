//
//  SparkCheckboxGroup.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// A Spark control that checkbox group between selected and unselected states on items.
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectedIDs = [Int]()
///
///     var body: some View {
///         SparkCheckboxGroup(
///             theme: self.theme,
///             selectedIDs: self.$selectedIDs,
///             items: [
///                 CheckboxGroupItem(
///                     id: 1,
///                     title: "My first item"
///                 ),
///                 CheckboxGroupItem(
///                     id: 2,
///                     title: "My last item"
///                 )
///             ]
///         )
///     }
/// }
/// ```
/// ![Checkbox group rendering with a Label.](checkboxGroup/component.png)
public struct SparkCheckboxGroup<ID, Label>: View where ID: SelectionControlsGroupID, Label: View {

    // MARK: - Properties

    private let theme: any Theme

    @Binding private var selectedIDs: [ID]
    private let items: [CheckboxGroupItem<ID, Label>]

    @Environment(\.checkboxGroupAxis) private var axis

    // MARK: - Initialization

    /// Creates a Spark checkbox with an empty label.
    ///
    /// Note : You must provide an *accessibilityLabel* !
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - selectedID: A binding to a property that indicates which checkbox is selected.
    ///   - items: The items (array of ``CheckboxGroupItem``) of the group.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectedIDs = [Int]()
    ///
    ///     var body: some View {
    ///         SparkCheckboxGroup(
    ///             theme: self.theme,
    ///             selectedIDs: self.$selectedIDs,
    ///             items: [
    ///                 CheckboxGroupItem(
    ///                     id: 1,
    ///                     title: "My first item"
    ///                 ),
    ///                 CheckboxGroupItem(
    ///                     id: 2,
    ///                     title: "My last item"
    ///                 )
    ///             ]
    ///         )
    ///     }
    /// }     
    /// ```
    ///
    /// ![Checkbox Group rendering.](checkboxGroup/component.png)
    public init(
        theme: any Theme,
        selectedIDs: Binding<[ID]>,
        items: [CheckboxGroupItem<ID, Label>]
    ) {
        self.theme = theme
        self._selectedIDs = selectedIDs
        self.items = items
    }

    // MARK: - View

    public var body: some View {
        CommonGroup(theme: self.theme) {
            ForEach(self.items, id: \.id) { item in
                SparkCheckbox(
                    theme: self.theme,
                    isSelected: Binding(
                        get: {
                            self.selectedIDs.contains(item.id)
                        },
                        set: { value in
                            if value && !self.selectedIDs.contains(item.id) {
                                self.selectedIDs.append(item.id)
                            } else if !value {
                                self.selectedIDs.removeAll(where: { $0 == item.id })
                            }
                        }
                    ),
                    label: item.label
                )
                .disabled(!item.isEnabled)
                .accessibilityIdentifier(CheckboxAccessibilityIdentifier.checkboxItem(id: item.id))
            }
        }
        .axis(self.axis)
        .accessibilityIdentifier(CheckboxAccessibilityIdentifier.group)
    }
}
