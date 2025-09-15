//
//  RadioButtonStyle.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon

struct RadioButtonStyle: ToggleStyle {

    // MARK: - Properties

    private let viewModel: RadioButtonViewModel

    @State private var isPressed: Bool = false

    @LimitedScaledMetric private var size: CGFloat
    @LimitedScaledMetric private var dotSize: CGFloat
    @LimitedScaledMetric private var lineWidth: CGFloat
    @LimitedScaledMetric private var hoverPadding: CGFloat

    // MARK: - Initialization

    init(viewModel: RadioButtonViewModel) {
        self.viewModel = viewModel

        self._size = .init(value: RadioButtonConstants.size)
        self._dotSize = .init(value: RadioButtonConstants.dotSize)
        self._lineWidth = .init(value: RadioButtonConstants.lineWidth)
        self._hoverPadding = .init(value: CommonConstants.hoverPadding)
    }

    // MARK: - Body

    func makeBody(configuration: Configuration) -> some View {
        Button {
            self.action(configuration: configuration)
        } label: {
            SparkHStack(viewModel: self.viewModel) {
                ZStack {

                    // Hidden label used to align the toggle and the label
                    configuration.label
                        .applyHiddenLabelStyle(
                            viewModel: self.viewModel,
                            width: self.size
                        )

                    // Circle
                    ZStack() {
                        Circle()
                            .strokeBorder(
                                self.viewModel.dynamicColors.circle.color,
                                lineWidth: self.lineWidth
                            )

                        self.dotView(configuration: configuration)
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
                    value: self.isPressed
                )
                .optionalAnimation(
                    .easeOut(duration: CommonConstants.animationDuration),
                    value: configuration.isOn == true
                )

                // Title
                configuration.label
                    .applyLabelStyle(
                        titleStyle: self.viewModel.titleStyle,
                        minHeight: self.size
                    )
            }
        }
        .buttonPressedStyle(self.$isPressed)
        .sensoryFeedback(trigger: configuration.isOn)
        .accessibilityAction {
            self.action(configuration: configuration)
        }
        .disabled(configuration.isOn)
    }

    // MARK: - Subview

    @ViewBuilder
    private func dotView(configuration: Configuration) -> some View {
        let size = configuration.isOn ? self.dotSize : 0
        Circle()
            .fill(self.viewModel.staticColors.dot)
            .frame(
                width: size,
                height: size
            )
    }

    @ViewBuilder
    private func pressedView(configuration: Configuration) -> some View {
        if !configuration.isOn, self.isPressed {
            Circle()
                .inset(by: -self.hoverPadding / 2)
                .stroke(
                    self.viewModel.staticColors.hover.color,
                    lineWidth: self.hoverPadding
                )
        } else {
            EmptyView()
        }
    }

    // MARK: - Actions

    private func action(configuration: Configuration) {
        if !configuration.isOn {
            configuration.isOn.toggle()
        }
    }
}

// MARK: - Extension

extension ToggleStyle where Self == RadioButtonStyle {

    static func custom(viewModel: RadioButtonViewModel) -> RadioButtonStyle {
        .init(viewModel: viewModel)
    }
}
