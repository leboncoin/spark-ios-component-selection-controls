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

// TODO: If Change the layout if the A11y dynamic is activated (same for RadioGroup)

/// A Spark control that checkbox group between selected and unselected states on items.
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectedIDs = false
///
///     var body: some View {
///         SparkCheckboxGroup(
///             theme: self.theme,
///             selectedIDs: self.$selectedIDs,
///             selectedIcon: .init(systemName: "checkmark")
///             label: {
///                 VStack {
///                     Text("Hello")
///                     Text("World")
///                 }
///             }
///         )
///     }
/// ```
/// ![Checkbox group rendering with a Label.](component_with_label.png)
public struct SparkCheckboxGroup<ID, Label>: View where ID: Equatable & Hashable & CustomStringConvertible, Label: View {

    // MARK: - Properties

    private let theme: Theme
    private let selectedIcon: Image

    @Binding private var selectedIDs: [ID]
    private let items: [CheckboxGroupItem<ID, Label>]

    @Environment(\.checkboxGroupAxis) private var axis

    @StateObject private var viewModel = CheckboxGroupViewModel()

    // MARK: - Initialization

    /// Creates a Spark checkbox with an empty label.
    ///
    /// Note : You must provide an *accessibilityLabel* !
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - selectedIDs: A binding to a property that indicates whether the checkbox is on or off.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectedIDs = false
    ///
    ///     var body: some View {
    ///         SparkCheckboxGroup(
    ///             theme: self.theme,
    ///             selectedIDs: self.$selectedIDs,
    ///             selectedIcon: .init(systemName: "checkmark")
    ///         )
    ///     }
    /// ```
    ///
    /// ![Toggle rendering.](component.png)
    public init(
        theme: Theme,
        selectedIDs: Binding<[ID]>,
        items: [CheckboxGroupItem<ID, Label>],
        selectedIcon: Image
    ) {
        self.theme = theme
        self._selectedIDs = selectedIDs
        self.items = items
        self.selectedIcon = selectedIcon
    }

    // MARK: - View

    public var body: some View {
        self.stack {
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
                    selectedIcon: self.selectedIcon,
                    label: item.label
                )
                .disabled(!item.isEnabled)
                .accessibilityIdentifier(CheckboxAccessibilityIdentifier.checkboxItem(id: item.id))
            }
        }
        .accessibilityIdentifier(CheckboxAccessibilityIdentifier.group)
        .onAppear() {
            self.viewModel.setup(
                theme: self.theme,
                axis: self.axis
            )
        }
        .onChange(of: self.axis) { axis in
            self.viewModel.axis = axis
        }
    }

    // MARK: - View Builder

    @ViewBuilder
    func stack<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        switch self.axis {
        case .vertical:
            VStack(
                alignment: .leading,
                spacing: self.viewModel.spacing,
                content: content
            )

        case .horizontal:
            HStack(
                alignment: .top,
                spacing: self.viewModel.spacing,
                content: content
            )
        }
    }
}
