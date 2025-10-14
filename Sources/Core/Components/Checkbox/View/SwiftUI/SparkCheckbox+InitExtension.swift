//
//  SparkCheckbox+InitExtension.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 31/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming

public extension SparkCheckbox {

    // MARK: - Initialization

    /// Creates a Spark checkbox with an empty label.
    ///
    /// Note : You must provide an *accessibilityLabel* !
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the checkbox is selected or unselected.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![Checkbox rendering.](checkbox_unselected.png)
    init(
        theme: any Theme,
        isSelected: Binding<Bool>
    ) where Label == EmptyView {
        self.init(
            theme: theme,
            selectionState: Binding(
                get: {
                    isSelected.wrappedValue ? .selected : .unselected
                },
                set: { value in
                    isSelected.wrappedValue = value == .selected
                }
            )
        )
    }

    /// Creates a Spark checkbox that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the checkbox's localized title, that describes
    ///     the purpose of the checkbox.
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the checkbox is selected or unselected.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             "My placeholder",
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![Checkbox rendering with a title.](checkbox_with_title.png)
    init(
        _ titleKey: LocalizedStringKey,
        theme: any Theme,
        isSelected: Binding<Bool>
    ) where Label == Text {
        self.init(
            titleKey,
            theme: theme,
            selectionState: Binding(
                get: {
                    isSelected.wrappedValue ? .selected : .unselected
                },
                set: { value in
                    isSelected.wrappedValue = value == .selected
                }
            )
        )
    }

    /// Creates a Spark checkbox that generates its label from a string.
    ///
    /// - Parameters:
    ///   - text: The text for the checkbox's localized title, that describes
    ///     the purpose of the checkbox.
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the checkbox is selected or unselected.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
    ///             "My placeholder",
    ///             theme: self.theme,
    ///             isSelected: self.$isSelected
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![Checkbox rendering with a title.](checkbox_with_title.png)
    init(
        _ text: String,
        theme: any Theme,
        isSelected: Binding<Bool>
    ) where Label == Text {
        self.init(
            text,
            theme: theme,
            selectionState: Binding(
                get: {
                    isSelected.wrappedValue ? .selected : .unselected
                },
                set: { value in
                    isSelected.wrappedValue = value == .selected
                }
            )
        )
    }

    /// Creates a Spark checkbox that displays a custom label.
    ///
    /// - Parameters:
    ///   - theme: The current theme.
    ///   - isSelected: A binding to a property that indicates whether the checkbox is selected or unselected.
    ///   - label: A view that describes the purpose of the checkbox.
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme()
    ///     @State var isSelected = false
    ///
    ///     var body: some View {
    ///         SparkCheckbox(
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
    /// }
    /// ```
    /// ![Checkbox rendering with a Label.](checkbox_with_label.png)
    init(
        theme: any Theme,
        isSelected: Binding<Bool>,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.init(
            theme: theme,
            selectionState: Binding(
                get: {
                    isSelected.wrappedValue ? .selected : .unselected
                },
                set: { value in
                    isSelected.wrappedValue = value == .selected
                }
            ),
            label: label
        )
    }
}
