//
//  ToggleViewModel.swift
//  SparkSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// ViewModel only used by **SwiftUI** View.
// sourcery: AutoPublisherTest, AutoViewModelStub
internal class ToggleViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published private(set) var dynamicColors = ToggleDynamicColors()
    @Published private(set) var staticColors = ToggleStaticColors()
    @Published private(set) var contentRadius: CGFloat = 0
    @Published private(set) var dim: CGFloat = 1
    @Published private(set) var titleFont: Font = .body
    @Published private(set) var isIcon: Bool = false
    @Published private(set) var spacing: CGFloat = 0
    @Published private(set) var showHiddenEmptyLabel = false

    // MARK: - Properties

    private var alreadyUpdateAll = false

    var theme: (any Theme)? {
        didSet {
            guard self.alreadyUpdateAll else { return }

            self.setDynamicColors()
            self.setStaticColors()
            self.setContentRadius()
            self.setDim()
            self.setFont()
            self.setSpacing()
        }
    }

    var isOn: Bool? {
        didSet {
            guard oldValue != self.isOn, self.alreadyUpdateAll else { return }

            self.setDynamicColors()
        }
    }

    var isOnOffSwitchLabelsEnabled: Bool? {
        didSet {
            guard oldValue != self.isOnOffSwitchLabelsEnabled, self.alreadyUpdateAll else { return }

            self.setIsIcon()
        }
    }

    var contrast: ColorSchemeContrast? {
        didSet {
            guard oldValue != self.contrast, self.alreadyUpdateAll else { return }

            self.setIsIcon()
        }
    }

    var isEnabled: Bool? {
        didSet {
            guard oldValue != self.isEnabled, self.alreadyUpdateAll else { return }

            self.setDim()
        }
    }

    private(set) var isCustomLabel: Bool?

    // MARK: - Use Case Properties

    private let getColorsUseCase: ToggleGetColorsUseCaseable
    private let getContentRadiusUseCase: ToggleGetContentRadiusUseCaseable
    private let getDimUseCase: ToggleGetDimUseCaseable
    private let getTitleFontUseCase: ToggleGetTitleFontUseCaseable
    private let getIsIconUseCase: ToggleGetIsIconUseCaseable
    private let getShowHiddenEmptyLabelUseCase: ToggleGetShowHiddenEmptyLabelUseCaseable
    private let getSpacingUseCase: ToggleGetSpacingUseCaseable

    // MARK: - Initialization

    init(
        getColorsUseCase: ToggleGetColorsUseCaseable = ToggleGetColorsUseCase(),
        getContentRadiusUseCase: ToggleGetContentRadiusUseCaseable = ToggleGetContentRadiusUseCase(),
        getDimUseCase: ToggleGetDimUseCaseable = ToggleGetDimUseCase(),
        getTitleFontUseCase: ToggleGetTitleFontUseCaseable = ToggleGetTitleFontUseCase(),
        getIsIconUseCase: ToggleGetIsIconUseCaseable = ToggleGetIsIconUseCase(),
        getShowHiddenEmptyLabelUseCase: ToggleGetShowHiddenEmptyLabelUseCaseable = ToggleGetShowHiddenEmptyLabelUseCase(),
        getSpacingUseCase: ToggleGetSpacingUseCaseable = ToggleGetSpacingUseCase()
    ) {
        self.getColorsUseCase = getColorsUseCase
        self.getContentRadiusUseCase = getContentRadiusUseCase
        self.getDimUseCase = getDimUseCase
        self.getTitleFontUseCase = getTitleFontUseCase
        self.getIsIconUseCase = getIsIconUseCase
        self.getShowHiddenEmptyLabelUseCase = getShowHiddenEmptyLabelUseCase
        self.getSpacingUseCase = getSpacingUseCase
    }

    // MARK: - Setup

    func setup(
        theme: Theme,
        isOn: Bool,
        isOnOffSwitchLabelsEnabled: Bool,
        contrast: ColorSchemeContrast,
        isEnabled: Bool,
        isCustomLabel: Bool
    ) {
        self.theme = theme
        self.isOn = isOn
        self.isOnOffSwitchLabelsEnabled = isOnOffSwitchLabelsEnabled
        self.contrast = contrast
        self.isEnabled = isEnabled
        self.isCustomLabel = isCustomLabel

        self.setDynamicColors()
        self.setStaticColors()
        self.setContentRadius()
        self.setDim()
        self.setFont()
        self.setIsIcon()
        self.setSpacing()
        self.setShowHiddenEmptyLabel()

        self.alreadyUpdateAll = true
    }

    // MARK: - Private Setter

    private func setDynamicColors() {
        guard let theme, let isOn else {
            return
        }

        self.dynamicColors = self.getColorsUseCase.executeDynamic(
            theme: theme,
            isOn: isOn
        )
    }

    private func setStaticColors() {
        guard let theme else {
            return
        }

        self.staticColors = self.getColorsUseCase.executeStatic(theme: theme)
    }

    private func setContentRadius() {
        guard let theme else {
            return
        }

        self.contentRadius = self.getContentRadiusUseCase.execute(theme: theme)
    }

    private func setDim() {
        guard let theme, let isEnabled else {
            return
        }

        self.dim = self.getDimUseCase.execute(
            theme: theme,
            isEnabled: isEnabled
        )
    }

    private func setFont() {
        guard let theme else {
            return
        }

        self.titleFont = self.getTitleFontUseCase.execute(theme: theme)
    }

    private func setIsIcon() {
        guard let isOnOffSwitchLabelsEnabled, let contrast else {
            return
        }

        self.isIcon = self.getIsIconUseCase.execute(
            isOnOffSwitchLabelsEnabled: isOnOffSwitchLabelsEnabled,
            contrast: contrast
        )
    }

    private func setSpacing() {
        guard let theme else {
            return
        }

        self.spacing = self.getSpacingUseCase.execute(theme: theme)
    }

    private func setShowHiddenEmptyLabel() {
        guard let isCustomLabel else {
            return
        }

        self.showHiddenEmptyLabel = self.getShowHiddenEmptyLabelUseCase.execute(
            isCustomLabel: isCustomLabel
        )
    }
}
