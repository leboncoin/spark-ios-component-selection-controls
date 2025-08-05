//
//  CommonUIViewModel.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 02/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// ViewModel only used by **UIKit** View.
// sourcery: AutoPublisherTest, AutoViewModelStub
internal class CommonUIViewModel<SelectedValue>: ObservableObject where SelectedValue : Equatable {

    // MARK: - Published Properties

    @Published private(set) var dim: CGFloat = 1
    @Published private(set) var contentRadius: CGFloat = 0
    @Published private(set) var spacing: CGFloat = 0
    @Published private(set) var titleStyle = CommonTitleStyle()

    // MARK: - Properties

    private let type: CommonType
    private var alreadyUpdateAll = false

    var theme: any Theme {
        didSet {
            guard self.alreadyUpdateAll else { return }

            self.setContentRadius()
            self.setDim()
            self.setFont()
            self.setSpacing()
        }
    }

    private(set) var selectedValue: SelectedValue {
        didSet {
            guard oldValue != self.selectedValue, self.alreadyUpdateAll else { return }

            self.selectedValueChanged(oldValue: oldValue)
        }
    }

    var isEnabled: Bool = true {
        didSet {
            guard oldValue != self.isEnabled, self.alreadyUpdateAll else { return }

            self.setDim()
        }
    }

    var isReduceMotionEnabled: Bool = false {
        didSet {
            guard oldValue != self.isReduceMotionEnabled, self.alreadyUpdateAll else { return }

            self.setAnimationType()
        }
    }

    private var selectedValueAnimated: Bool = true {
        didSet {
            guard oldValue != self.selectedValueAnimated, self.alreadyUpdateAll else { return }

            self.setAnimationType()
        }
    }

    private(set) var animationType: UIExecuteAnimationType = .unanimated

    // MARK: - Use Case Properties

    private let getAnimationTypeUseCase: CommonGetAnimationTypeUseCaseable
    private let getDimUseCase: CommonGetDimUseCaseable
    private let getContentRadiusUseCase: CommonGetContentRadiusUseCaseable
    private let getSpacingUseCase: CommonGetSpacingUseCaseable
    private let getTitleStyleUseCase: CommonGetTitleStyleUseCaseable

    // MARK: - Initialization

    init(
        type: CommonType,
        theme: any Theme,
        selectedValue: SelectedValue,
        getAnimationTypeUseCase: CommonGetAnimationTypeUseCaseable = CommonGetAnimationTypeUseCase(),
        getDimUseCase: CommonGetDimUseCaseable = CommonGetDimUseCase(),
        getContentRadiusUseCase: CommonGetContentRadiusUseCaseable = CommonGetContentRadiusUseCase(),
        getSpacingUseCase: CommonGetSpacingUseCaseable = CommonGetSpacingUseCase(),
        getTitleStyleUseCase: CommonGetTitleStyleUseCaseable = CommonGetTitleStyleUseCase()
    ) {
        self.type = type
        self.selectedValue = selectedValue
        self.theme = theme

        self.getAnimationTypeUseCase = getAnimationTypeUseCase
        self.getDimUseCase = getDimUseCase
        self.getContentRadiusUseCase = getContentRadiusUseCase
        self.getSpacingUseCase = getSpacingUseCase
        self.getTitleStyleUseCase = getTitleStyleUseCase
    }

    // MARK: - Load

    func load(
        isReduceMotionEnabled: Bool
    ) {
        self.isReduceMotionEnabled = isReduceMotionEnabled

        self.setAnimationType()
        self.setContentRadius()
        self.setDim()
        self.setFont()
        self.setSpacing()

        self.alreadyUpdateAll = true
    }

    // MARK: - Action

    func setSelectedValue(_ selectedValue: SelectedValue, animated: Bool = false) {
        guard selectedValue != self.selectedValue else { return }

        self.selectedValueAnimated = animated
        self.selectedValue = selectedValue
    }

    // MARK: - Update

    func selectedValueChanged(oldValue: SelectedValue) {
    }

    // MARK: - Private Setter

    private func setContentRadius() {
        self.contentRadius = self.getContentRadiusUseCase.execute(
            theme: self.theme,
            type: self.type
        )
    }

    private func setDim() {
        self.dim = self.getDimUseCase.execute(
            theme: self.theme,
            isEnabled: self.isEnabled
        )
    }

    private func setFont() {
        self.titleStyle = self.getTitleStyleUseCase.execute(theme: self.theme)
    }

    private func setSpacing() {
        self.spacing = self.getSpacingUseCase.execute(theme: self.theme)
    }

    private func setAnimationType() {
        self.animationType = self.getAnimationTypeUseCase.execute(
            selectedValueAnimated: self.selectedValueAnimated,
            isReduceMotionEnabled: self.isReduceMotionEnabled
        )
    }
}
