//
//  SparkRadioButton.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// A Spark control that radio buttons between on and off states.
///
/// There is some possibilities to init the component :
/// - Without title:
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var isSelected = false
///
///     var body: some View {
///         SparkRadioButton(
///             theme: self.theme,
///             isSelected: self.$isSelected
///         )
///     }
/// ```
/// Radio button when isSelected is **true** :
/// ![Radio button rendering.](component.png)
///
/// Radio button when isSelected is **false**:
/// ![Radio button rendering.](component_disabled.png)
///
/// - With a localized string key or a string:
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var isSelected = false
///
///     var body: some View {
///         SparkRadioButton(
///             "My placeholder",
///             theme: self.theme,
///             isSelected: self.$isSelected
///         )
///     }
/// ```
/// ![Radio button rendering with a title.](component_with_title.png)
///
/// ![Radio button rendering with a multiline text.](component_with_mutliline.png)
///
/// - With a custom Label:
/// **Use it carefully with Spark font and color !**
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var isSelected = false
///
///     var body: some View {
///         SparkRadioButton(
///             theme: self.theme,
///             isSelected: self.$isSelected
///             label: {
///                 VStack {
///                     Text("Hello")
///                     Text("World")
///                 }
///             }
///         )
///     }
/// ```
/// ![Radio button rendering with a Label.](component_with_label.png)
public struct SparkRadioButton<Label>: View where Label: View {

    // MARK: - Properties

    private let theme: Theme
    @Binding private var isSelected: Bool
    private let label: () -> Label

    @Environment(\.radioButtonIntent) private var intent
    @Environment(\.isEnabled) private var isEnabled

    @StateObject private var viewModel = RadioButtonViewModel()

    // MARK: - Initialization

    /// Creates a Spark radio button with an empty label.
    ///
    /// Note : You must provide an *accessibilityLabel* !
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the radio button is on or off.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkRadioButton(
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected
    ///         )
    ///     }
    /// ```
    ///
    /// ![Radio button rendering.](component.png)
    public init(
        theme: Theme,
        isSelected: Binding<Bool>
    ) where Label == EmptyView {
        self.theme = theme
        self._isSelected = isSelected
        self.label = { EmptyView() }
    }

    /// Creates a Spark radio button that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the radio button's localized title, that describes
    ///     the purpose of the radio button.
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the radio button is on or off.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkRadioButton(
    ///             "My placeholder",
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected
    ///         )
    ///     }
    /// ```
    ///
    /// ![Radio button rendering with a title.](component_with_title.png)
    public init(
        _ titleKey: LocalizedStringKey,
        theme: Theme,
        isSelected: Binding<Bool>
    ) where Label == Text {
        self.theme = theme
        self._isSelected = isSelected
        self.label = { Text(titleKey) }
    }

    /// Creates a Spark radio button that generates its label from a string.
    ///
    /// - Parameters:
    ///   - text: The text for the radio button's localized title, that describes
    ///     the purpose of the radio button.
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the radio button is on or off.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkRadioButton(
    ///             "My placeholder",
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected
    ///         )
    ///     }
    /// ```
    ///
    /// ![Radio button rendering with a title.](component_with_title.png)
    public init(
        _ text: String,
        theme: Theme,
        isSelected: Binding<Bool>
    ) where Label == Text {
        self.theme = theme
        self._isSelected = isSelected
        self.label = { Text(text) }
    }

    /// Creates a Spark radio button that displays a custom label.
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the radio button is on or off.
    ///   - label: A view that describes the purpose of the radio button.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkRadioButton(
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected,
    ///             label: {
    ///                 VStack {
    ///                     Text("Hello")
    ///                     Text("World")
    ///                 }
    ///             }
    ///         )
    ///     }
    /// ```
    /// ![Radio button rendering with a Label.](component_with_label.png)
    public init(
        theme: Theme,
        isSelected: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.theme = theme
        self._isSelected = isSelected
        self.label = label
    }

    // MARK: - View

    public var body: some View {
        Toggle(
            isOn: self.$isSelected,
            label: self.label
        )
        .toggleStyle(.custom(viewModel: self.viewModel))
        .accessibilityIdentifier(RadioButtonAccessibilityIdentifier.view)
        .onAppear() {
            self.viewModel.setup(
                theme: self.theme,
                intent: self.intent,
                isOn: self.isSelected,
                isEnabled: self.isEnabled,
                isCustomLabel: Label.self != EmptyView.self && Label.self != Text.self
            )
        }
        .onChange(of: self.intent) { intent in
            self.viewModel.intent = intent
        }
        .onChange(of: self.isSelected) { isSelected in
            self.viewModel.isOn = isSelected
        }
        .onChange(of: self.isEnabled) { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
    }
}
