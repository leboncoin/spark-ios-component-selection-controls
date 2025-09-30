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
///             selectionState: self.$selectionState
///         )
///     }
/// }
/// ```
///
/// Checkbox when selectionState is **selected** or isSelected is **true**:
/// ![Checkbox rendering.](checkbox/component_selected.png)
///
/// Checkbox when selectionState is **unselected** or isSelected is **false**:
/// ![Checkbox rendering.](checkbox/component_unselected.png)
///
/// Checkbox when selectionState is **indeterminate**:
/// ![Checkbox rendering.](checkbox/component_indeterminate.png)
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
///             selectionState: self.$selectionState
///         )
///     }
/// }
/// ```
/// ![Checkbox rendering with a title.](checkbox/component_with_title.png)
///
/// ![Checkbox rendering with a multiline text.](checkbox/component_with_mutliline.png)
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
///             label: {
///                 VStack {
///                     Text("Hello")
///                     Text("World")
///                 }
///             }
///         )
///     }
/// }
/// ```
/// ![Checkbox rendering with a Label.](checkbox/component_with_label.png)
public struct SparkCheckbox<Label>: View where Label: View {

    // MARK: - Properties

    private let theme: any Theme
    @Binding private var selectionState: CheckboxSelectionState
    private let selectedIcon: Image = .sparkCheck
    private let indeterminateIcon: Image? = .sparkMinus
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
    ///             selectionState: self.$selectionState
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![Checkbox rendering.](checkbox/component_unselected.png)
    public init(
        theme: any Theme,
        selectionState: Binding<CheckboxSelectionState>
    ) where Label == EmptyView {
        self.theme = theme
        self._selectionState = selectionState
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
    ///             selectionState: self.$selectionState
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![Checkbox rendering with a title.](checkbox/component_with_title.png)
    public init(
        _ titleKey: LocalizedStringKey,
        theme: any Theme,
        selectionState: Binding<CheckboxSelectionState>
    ) where Label == Text {
        self.theme = theme
        self._selectionState = selectionState
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
    ///             selectionState: self.$selectionState
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![Checkbox rendering with a title.](checkbox/component_with_title.png)
    public init(
        _ text: String,
        theme: any Theme,
        selectionState: Binding<CheckboxSelectionState>
    ) where Label == Text {
        self.theme = theme
        self._selectionState = selectionState
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
    ///             selectionState: self.$selectionState,
    ///             label: {
    ///                 VStack {
    ///                     Text("Hello")
    ///                     Text("World")
    ///                 }
    ///             }
    ///         )
    ///     }
    /// }     
    /// ```
    /// ![Checkbox rendering with a Label.](checkbox/component_with_label.png)
    public init(
        theme: any Theme,
        selectionState: Binding<CheckboxSelectionState>,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.theme = theme
        self._selectionState = selectionState
        self.label = label
    }

    // MARK: - View

    public var body: some View {
        Toggle(
            isOn: Binding(
                get: {
                    self.selectionState == .selected
                }, set: { newValue in
                    self.selectionState = newValue ? .selected : .unselected
                }
            ),
            label: self.label
        )
        .toggleStyle(.custom(
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
