//
//  SparkCheckbox.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// A Spark control that checkbox between selected, unselected or indeterminate states.
///
/// There is some possibilities to init the component :
/// - Without title:
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectionState = .unselected
///
///     var body: some View {
///         SparkCheckbox(
///             theme: self.theme,
///             selectionState: self.$selectionState,
///             selectedIcon: .init(systemName: "checkmark"),
///             indeterminateIcon: .init(systemName: "square")
///         )
///     }
/// ```
/// Checkbox when selectionState is **true** :
/// ![Checkbox rendering.](component.png)
///
/// Checkbox when selectionState is **.unselected**:
/// ![Checkbox rendering.](component_disabled.png)
///
/// - With a localized string key or a string:
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectionState = .unselected
///
///     var body: some View {
///         SparkCheckbox(
///             "My placeholder",
///             theme: self.theme,
///             selectionState: self.$selectionState,
///             selectedIcon: .init(systemName: "checkmark"),
///             indeterminateIcon: .init(systemName: "square")
///         )
///     }
/// ```
/// ![Checkbox rendering with a title.](component_with_title.png)
///
/// ![Checkbox rendering with a multiline text.](component_with_mutliline.png)
///
/// - With a custom Label:
/// **Use it carefully with Spark font and color !**
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///     @State var selectionState = .unselected
///
///     var body: some View {
///         SparkCheckbox(
///             theme: self.theme,
///             selectionState: self.$selectionState,
///             selectedIcon: .init(systemName: "checkmark"),
///             indeterminateIcon: .init(systemName: "square")
///             label: {
///                 VStack {
///                     Text("Hello")
///                     Text("World")
///                 }
///             }
///         )
///     }
/// ```
/// ![Checkbox rendering with a Label.](component_with_label.png)
public struct SparkCheckbox<Label>: View where Label: View {

    // MARK: - Properties

    private let theme: Theme
    @Binding private var selectionState: CheckboxSelectionState
    private let selectedIcon: Image
    private let indeterminateIcon: Image?
    private let label: () -> Label
    
    @Environment(\.checkboxIntent) private var intent
    @Environment(\.isEnabled) private var isEnabled

    @StateObject private var viewModel = CheckboxViewModel()

    // MARK: - Selection State Initialization

    /// Creates a Spark checkbox with an empty label.
    ///
    /// Note : You must provide an *accessibilityLabel* !
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - selectionState: A binding to a property that indicates the checkbox selection state.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectionState = .unselected
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             theme: self.theme,
    ///             selectionState: self.$selectionState,
    ///             selectedIcon: .init(systemName: "checkmark"),
    ///             indeterminateIcon: .init(systemName: "square")
    ///         )
    ///     }
    /// ```
    ///
    /// ![Checkbox rendering.](component.png)
    public init(
        theme: Theme,
        selectionState: Binding<CheckboxSelectionState>,
        selectedIcon: Image,
        indeterminateIcon: Image?
    ) where Label == EmptyView {
        self.theme = theme
        self._selectionState = selectionState
        self.selectedIcon = selectedIcon
        self.indeterminateIcon = indeterminateIcon
        self.label = { EmptyView() }
    }

    /// Creates a Spark checkbox that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the checkbox's localized title, that describes
    ///     the purpose of the checkbox.
    ///   - theme: The current theme.
    ///   - selectionState: A binding to a property that indicates the checkbox selection state.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectionState = .unselected
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             "My placeholder",
    ///             theme: self.theme,
    ///             selectionState: self.$selectionState,
    ///             selectedIcon: .init(systemName: "checkmark"),
    ///             indeterminateIcon: .init(systemName: "square")
    ///         )
    ///     }
    /// ```
    ///
    /// ![Checkbox rendering with a title.](component_with_title.png)
    public init(
        _ titleKey: LocalizedStringKey,
        theme: Theme,
        selectionState: Binding<CheckboxSelectionState>,
        selectedIcon: Image,
        indeterminateIcon: Image?
    ) where Label == Text {
        self.theme = theme
        self._selectionState = selectionState
        self.selectedIcon = selectedIcon
        self.indeterminateIcon = indeterminateIcon
        self.label = { Text(titleKey) }
    }

    /// Creates a Spark checkbox that generates its label from a string.
    ///
    /// - Parameters:
    ///   - text: The text for the checkbox's localized title, that describes
    ///     the purpose of the checkbox.
    ///   - theme: The current theme.
    ///   - selectionState: A binding to a property that indicates the checkbox selection state.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectionState = .unselected
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             "My placeholder",
    ///             theme: self.theme,
    ///             selectionState: self.$selectionState,
    ///             selectedIcon: .init(systemName: "checkmark"),
    ///             indeterminateIcon: .init(systemName: "square")
    ///         )
    ///     }
    /// ```
    ///
    /// ![Checkbox rendering with a title.](component_with_title.png)
    public init(
        _ text: String,
        theme: Theme,
        selectionState: Binding<CheckboxSelectionState>,
        selectedIcon: Image,
        indeterminateIcon: Image?
    ) where Label == Text {
        self.theme = theme
        self._selectionState = selectionState
        self.selectedIcon = selectedIcon
        self.indeterminateIcon = indeterminateIcon
        self.label = { Text(text) }
    }

    /// Creates a Spark checkbox that displays a custom label.
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - selectionState: A binding to a property that indicates the checkbox selection state.
    ///   - label: A view that describes the purpose of the checkbox.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var selectionState = .unselected
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             theme: self.theme,
    ///             selectionState: self.$selectionState,,
    ///             selectedIcon: .init(systemName: "checkmark"),
    ///             indeterminateIcon: .init(systemName: "square")
    ///             label: {
    ///                 VStack {
    ///                     Text("Hello")
    ///                     Text("World")
    ///                 }
    ///             }
    ///         )
    ///     }
    /// ```
    /// ![Checkbox rendering with a Label.](component_with_label.png)
    public init(
        theme: Theme,
        selectionState: Binding<CheckboxSelectionState>,
        selectedIcon: Image,
        indeterminateIcon: Image?,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.theme = theme
        self._selectionState = selectionState
        self.selectedIcon = selectedIcon
        self.indeterminateIcon = indeterminateIcon
        self.label = label
    }

    // MARK: - View

    public var body: some View {
        Button(
            action: {
                switch self.selectionState {
                case .selected:
                    self.selectionState = .unselected
                case .unselected, .indeterminate:
                    self.selectionState = .selected
                }
            },
            label: self.label
        )
        .buttonStyle(.custom(
            viewModel: self.viewModel,
            selectedIcon: self.selectedIcon,
            indeterminateIcon: self.indeterminateIcon
        ))
        .accessibilityIdentifier(CheckboxAccessibilityIdentifier.view)
        .onAppear() {
            self.viewModel.setup(
                theme: self.theme,
                intent: self.intent,
                selectionState: self.selectionState,
                isEnabled: self.isEnabled,
                isCustomLabel: Label.self != EmptyView.self && Label.self != Text.self
            )
        }
        .onChange(of: self.intent) { intent in
            self.viewModel.intent = intent
        }
        .onChange(of: self.selectionState) { selectionState in
            self.viewModel.selectionState = selectionState
        }
        .onChange(of: self.isEnabled) { isEnabled in
            self.viewModel.isEnabled = isEnabled
        }
    }
}
