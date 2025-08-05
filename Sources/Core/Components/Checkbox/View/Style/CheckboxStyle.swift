//
//  CheckboxStyle.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon

// TODO: Animation issue ! Retry to use a ToggleStyle ..?

// TODO: Accessibility Action ??
// TODO: Voice over

struct CheckboxStyle: ButtonStyle {

    // MARK: - Properties

    @StateObject private var viewModel: CheckboxViewModel

    private let selectedIcon: Image
    private let indeterminateIcon: Image?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled

    @LimitedScaledMetric private var size: CGFloat
    @LimitedScaledMetric private var lineWidth: CGFloat
    @LimitedScaledMetric private var iconPadding: CGFloat
    @LimitedScaledMetric private var hoverPadding: CGFloat
    @LimitedScaledMetric private var rectangleRadius: CGFloat

    // MARK: - Initialization

    init(
        viewModel: CheckboxViewModel,
        selectedIcon: Image,
        indeterminateIcon: Image?
    ) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.selectedIcon = selectedIcon
        self.indeterminateIcon = indeterminateIcon

        self._size = .init(value: CheckboxConstants.size)
        self._lineWidth = .init(value: CheckboxConstants.lineWidth)
        self._iconPadding = .init(value: CheckboxConstants.iconPadding)
        self._hoverPadding = .init(value: CommonConstants.hoverPadding)
        self._rectangleRadius = .init(value: viewModel.contentRadius)
    }

    // MARK: - Body

    func makeBody(configuration: Configuration) -> some View {
        ScaledHStack(viewModel: self.viewModel) {
            ZStack {

                // Hidden label used to align the toggle and the label
                configuration.label
                    .applyHiddenLabelStyle(
                        viewModel: self.viewModel,
                        width: self.size
                    )

                Rectangle()
                    .fill(self.viewModel.dynamicColors.background)
                    .clipShape(
                        RoundedRectangle(cornerRadius: self.rectangleRadius)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: self.rectangleRadius)
                            .strokeBorder(
                                self.viewModel.dynamicColors.border.color,
                                lineWidth: self.lineWidth
                            )
                    }
                    .overlay {
                        self.icon()
                    }
                    .opacity(self.viewModel.dim)
                    .frame(
                        width: self.size,
                        height: self.size
                    )
                    .transaction()
                    .overlay(
                        self.pressedView(configuration: configuration)
                    )
            }
            .optionalAnimation(
                .easeInOut(duration: CommonConstants.animationDuration),
                value: configuration.isPressed
            )
            .optionalAnimation(
                .easeOut(duration: CheckboxConstants.secondAnimationDuration),
                value: self.viewModel.selectionState
            )

            // Title
            configuration.label
                .applyLabelStyle(
                    titleStyle: self.viewModel.titleStyle,
                    minHeight: self.size
                )
        }
        .sensoryFeedback(trigger: configuration.isPressed)
    }

    // MARK: - Subview

    @ViewBuilder
    func icon() -> some View {
        let icon: Image? = switch self.viewModel.selectionState {
        case .selected: self.selectedIcon
        case .indeterminate: self.indeterminateIcon
        default: nil
        }

        if let icon, self.viewModel.isIcon {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(self.viewModel.staticColors.iconForeground)
                .padding(self.iconPadding)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder func pressedView(configuration: Configuration) -> some View {
        if configuration.isPressed {
            RoundedRectangle(cornerRadius: self.rectangleRadius)
                .inset(by: -self.hoverPadding / 2)
                .stroke(
                    self.viewModel.staticColors.hover.color,
                    lineWidth: CommonConstants.hoverPadding
                )
        } else {
            EmptyView()
        }
    }
}

// MARK: - Extension

extension ButtonStyle where Self == CheckboxStyle {

    static func custom(
        viewModel: CheckboxViewModel,
        selectedIcon: Image,
        indeterminateIcon: Image?
    ) -> CheckboxStyle {
        .init(
            viewModel: viewModel,
            selectedIcon: selectedIcon,
            indeterminateIcon: indeterminateIcon
        )
    }
}
