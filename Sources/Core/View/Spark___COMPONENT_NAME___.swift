//
//  Spark___COMPONENT_NAME___.swift
//  Spark___COMPONENT_NAME___
//
//  Created by ___USERNAME___ on ___CURRENT_DATE___.
//  Copyright © ___CURRENT_YEAR___ Leboncoin. All rights reserved.
//

import SwiftUI
import SparkTheming
@_spi(SI_SPI) import SparkCommon

/// TODO: Add title
///
/// TODO: Add description
///
/// Implementation example :
/// ```swift
/// struct MyView: View {
///     let theme: SparkTheming.Theme = MyTheme()
///
///     var body: some View {
///         Spark___COMPONENT_NAME___(
///             TODO: 
///         )
///     }
/// }
/// ```
///
/// ![___COMPONENT_NAME___ rendering.](component.png)
///
public struct Spark___COMPONENT_NAME___: View {

    // MARK: - Private Properties

    @ObservedObject private var viewModel: ___COMPONENT_NAME___ViewModel

    // MARK: - Initialization

    /// TODO: Add title
    ///
    /// Implementation example :
    /// ```swift
    /// struct MyView: View {
    ///     let theme: SparkTheming.Theme = MyTheme(
    ///
    ///     var body: some View {
    ///         Spark___COMPONENT_NAME___(
    ///             theme: self.theme,
    ///             intent: .main,
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// ![___COMPONENT_NAME___ rendering.](component.png)
    ///
    /// - Parameters:
    ///   - theme: The spark theme of the ___component_name___.
    ///   - intent: The intent of the ___component_name___.
    public init(
        theme: Theme,
        intent: ___COMPONENT_NAME___Intent
    ) {
        self.viewModel = ___COMPONENT_NAME___ViewModel(
            theme: theme,
            intent: intent
        )
    }

    // MARK: - View

    public var body: some View {
        Text("Hello ___COMPONENT_NAME___")
            .accessibilityIdentifier(___COMPONENT_NAME___AccessibilityIdentifier.view)
    }

    // MARK: - Modifier

    // TODO:
}
