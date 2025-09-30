//
//  ToggleCustomStyle.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon

struct ToggleCustomStyle: ToggleStyle {

    // MARK: - Properties

    private let viewModel: ToggleViewModel
    private let onIcon: Image = .sparkCheck
    private let offIcon: Image = .sparkCross

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var isPressed: Bool = false

    // MARK: - Initialization

    init(viewModel: ToggleViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    func makeBody(configuration: Configuration) -> some View {
        SparkHStack(viewModel: self.viewModel) {
            ZStack {

                // Hidden label used to align the toggle and the label
                configuration.label
                    .applyHiddenLabelStyle(
                        viewModel: self.viewModel,
                        width: ToggleConstants.width
                    )

                // Toggle
                Button {
                    configuration.isOn.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: self.viewModel.contentRadius)
                        .fill(self.viewModel.dynamicColors.background)
                        .overlay {
                            ZStack {
                                HStack(alignment: .center, spacing: 0) {
                                    if configuration.isOn {
                                        Spacer()
                                    }

                                    RoundedRectangle(cornerRadius: self.viewModel.contentRadius)
                                        .fill(self.viewModel.staticColors.dotBackground)
                                        .padding(ToggleConstants.padding)
                                        .frame(
                                            width: self.canChangeDotSize() ? ToggleConstants.dotPressedSize : ToggleConstants.dotSize
                                        )
                                        .overlay {
                                            if self.viewModel.isIcon {
                                                self.icon(configuration: configuration)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .foregroundStyle(self.viewModel.dynamicColors.dotForeground)
                                                    .frame(size: ToggleConstants.dotIconSize)
                                            }
                                        }

                                    if !configuration.isOn {
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .opacity(self.viewModel.dim)
                        .frame(
                            width: ToggleConstants.width,
                            height: ToggleConstants.height
                        )
                        .transaction()
                        .overlay(
                            self.pressedView()
                        )
                }
                .buttonPressedStyle(self.$isPressed)
                .sparkSensoryFeedback(trigger: configuration.isOn)
                .optionalAnimation(
                    .easeInOut(duration: CommonConstants.animationDuration),
                    value: self.isPressed
                )
                .optionalAnimation(
                    .easeOut(duration: CommonConstants.animationDuration),
                    value: configuration.isOn
                )
                .accessibilityAction {
                    configuration.isOn.toggle()
                }
            }

            // Title
            configuration.label
                .applyLabelStyle(
                    titleStyle: self.viewModel.titleStyle,
                    minHeight: ToggleConstants.height
                )
        }
    }

    // MARK: - Subview

    private func icon(configuration: Configuration) -> Image {
        if configuration.isOn {
            self.onIcon
        } else {
            self.offIcon
        }
    }

    @ViewBuilder
    private func pressedView() -> some View {
        if self.isPressed {
            RoundedRectangle(cornerRadius: self.viewModel.contentRadius)
                .inset(by: -CommonConstants.hoverPadding / 2)
                .stroke(
                    self.viewModel.staticColors.hover.color,
                    lineWidth: CommonConstants.hoverPadding
                )
        } else {
            EmptyView()
        }
    }

    // MARK: - Getter

    private func canChangeDotSize() -> Bool {
        self.isPressed && !self.reduceMotion
    }
}

// MARK: - Extension

extension ToggleStyle where Self == ToggleCustomStyle {

    static func custom(viewModel: ToggleViewModel) -> ToggleCustomStyle {
        .init(viewModel: viewModel)
    }
}

// MARK: - Private Extension

private extension View {

    func frame(size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
}
