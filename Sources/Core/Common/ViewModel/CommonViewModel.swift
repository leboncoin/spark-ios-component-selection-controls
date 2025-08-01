//
//  CommonViewModel.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// ViewModel only used by **SwiftUI** View.
// sourcery: AutoPublisherTest, AutoViewModelStub
internal class CommonViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published private(set) var contentRadius: CGFloat = 0
    @Published private(set) var dim: CGFloat = 1
    @Published private(set) var titleStyle = CommonTitleStyle()
    @Published private(set) var showHiddenEmptyLabel = false
    @Published private(set) var spacing: CGFloat = 0

    // MARK: - Properties

    private let type: CommonType
    private var alreadyUpdateAll = false

    var theme: (any Theme)? {
        didSet {
            guard self.alreadyUpdateAll else { return }

            self.setContentRadius()
            self.setDim()
            self.setFont()
            self.setSpacing()
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

    private let getContentRadiusUseCase: CommonGetContentRadiusUseCaseable
    private let getDimUseCase: CommonGetDimUseCaseable
    private let getTitleStyleUseCase: CommonGetTitleStyleUseCaseable
    private let getShowHiddenEmptyLabelUseCase: CommonGetShowHiddenEmptyLabelUseCaseable
    private let getSpacingUseCase: CommonGetSpacingUseCaseable

    // MARK: - Initialization

    init(
        type: CommonType,
        getContentRadiusUseCase: CommonGetContentRadiusUseCaseable = CommonGetContentRadiusUseCase(),
        getDimUseCase: CommonGetDimUseCaseable = CommonGetDimUseCase(),
        getTitleStyleUseCase: CommonGetTitleStyleUseCaseable = CommonGetTitleStyleUseCase(),
        getShowHiddenEmptyLabelUseCase: CommonGetShowHiddenEmptyLabelUseCaseable = CommonGetShowHiddenEmptyLabelUseCase(),
        getSpacingUseCase: CommonGetSpacingUseCaseable = CommonGetSpacingUseCase()
    ) {
        self.type = type

        self.getContentRadiusUseCase = getContentRadiusUseCase
        self.getDimUseCase = getDimUseCase
        self.getTitleStyleUseCase = getTitleStyleUseCase
        self.getShowHiddenEmptyLabelUseCase = getShowHiddenEmptyLabelUseCase
        self.getSpacingUseCase = getSpacingUseCase
    }

    // MARK: - Setup

    func setup(
        theme: Theme,
        isEnabled: Bool,
        isCustomLabel: Bool
    ) {
        self.theme = theme
        self.isEnabled = isEnabled
        self.isCustomLabel = isCustomLabel

        self.setContentRadius()
        self.setDim()
        self.setFont()
        self.setShowHiddenEmptyLabel()
        self.setSpacing()

        self.alreadyUpdateAll = true
    }

    // MARK: - Private Setter

    private func setContentRadius() {
        guard let theme else {
            return
        }

        self.contentRadius = self.getContentRadiusUseCase.execute(
            theme: theme,
            type: self.type
        )
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

        self.titleStyle = self.getTitleStyleUseCase.execute(theme: theme)
    }

    private func setShowHiddenEmptyLabel() {
        guard let isCustomLabel else {
            return
        }

        self.showHiddenEmptyLabel = self.getShowHiddenEmptyLabelUseCase.execute(
            isCustomLabel: isCustomLabel
        )
    }

    private func setSpacing() {
        guard let theme else {
            return
        }

        self.spacing = self.getSpacingUseCase.execute(theme: theme)
    }
}
