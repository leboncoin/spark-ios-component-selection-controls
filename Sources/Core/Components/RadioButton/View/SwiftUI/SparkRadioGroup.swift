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

/// A Spark control that radio group between on and off states.
///
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectedID = false
///
///     var body: some View {
///         SparkRadioGroup(
///             theme: self.theme,
///             selectedID: self.$selectedID
///             label: {
///                 VStack {
///                     Text("Hello")
///                     Text("World")
///                 }
///             }
///         )
///     }
/// ```
/// ![Radio group rendering with a Label.](component_with_label.png)
public struct SparkRadioGroup<ID, Label>: View where ID: Equatable & Hashable & CustomStringConvertible, Label: View {

    // MARK: - Properties

    private let theme: Theme

    @Binding private var selectedID: ID?
    private let items: [RadioGroupItem<ID, Label>]

    @Environment(\.radioGroupAxis) private var axis

    @StateObject private var viewModel = RadioGroupViewModel()

    // MARK: - Initialization

    /// Creates a Spark radio button with an empty label.
    ///
    /// Note : You must provide an *accessibilityLabel* !
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - selectedID: A binding to a property that indicates whether the radio button is on or off.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectedID = false
    ///
    ///     var body: some View {
    ///         SparkRadioGroup(
    ///             theme: self.theme,
    ///             selectedID: self.$selectedID
    ///         )
    ///     }
    /// ```
    ///
    /// ![Toggle rendering.](component.png)
    public init(
        theme: Theme,
        selectedID: Binding<ID?>,
        items: [RadioGroupItem<ID, Label>]
    ) {
        self.theme = theme
        self._selectedID = selectedID
        self.items = items
    }

    // MARK: - View

    public var body: some View {
        self.stack {
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
        .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.group)
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
