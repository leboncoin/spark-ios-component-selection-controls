//
//  CommonGroup.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

internal struct CommonGroup<Content>: View where Content: View {

    // MARK: - Properties

    private let theme: any Theme
    @ViewBuilder private let content: () -> Content
    private var axis: SelectionControlsAxis = .default

    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    @StateObject private var viewModel = CommonGroupViewModel()

    // MARK: - Initialization

    init(
        theme: any Theme,
        content: @escaping () -> Content
    ) {
        self.theme = theme
        self.content = content
    }

    // MARK: - View

    var body: some View {
        self.stack()
            .onAppear() {
                self.viewModel.setup(
                    theme: self.theme,
                    axis: self.axis,
                    isAccessibilitySize: self.dynamicTypeSize.isAccessibilitySize
                )
            }
            .onChange(of: self.axis) { axis in
                self.viewModel.axis = axis
            }
            .onChange(of: self.dynamicTypeSize) { dynamicTypeSize in
                self.viewModel.isAccessibilitySize = dynamicTypeSize.isAccessibilitySize
            }
    }

    // MARK: - View Builder

    @ViewBuilder
    func stack() -> some View {
        switch self.axis {
        case .vertical:
            VStack(
                alignment: .leading,
                spacing: self.viewModel.spacing,
                content: self.content
            )

        case .horizontal:
            SparkAdaptiveStack(
                axis: .horizontal,
                alignment: .top,
                spacing: self.viewModel.spacing,
                accessibilityAlignment: .leading,
                content: self.content
            )
        }
    }

    // MARK: - View Modifier

    func axis(_ axis: SelectionControlsAxis) -> Self {
        var copy = self
        copy.axis = axis
        return copy
    }
}
