//
//  CheckboxViewModel.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 22/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

/// ViewModel only used by **SwiftUI** View.
// sourcery: AutoPublisherTest, AutoViewModelStub
final internal class CheckboxViewModel: CommonViewModel {

    // MARK: - Published Properties

    @Published private(set) var dynamicColors = CheckboxDynamicColors()
    @Published private(set) var staticColors = CheckboxStaticColors()
    @Published private(set) var isIcon: Bool = false

    // MARK: - Properties

    private var alreadyUpdateAll = false

    override var theme: (any Theme)? {
        didSet {
            guard self.alreadyUpdateAll else { return }

            self.setDynamicColors()
            self.setStaticColors()
        }
    }

    var intent: CheckboxIntent? {
        didSet {
            guard oldValue != self.intent, self.alreadyUpdateAll else { return }

            self.setDynamicColors()
            self.setStaticColors()
        }
    }

    var selectionState: CheckboxSelectionState? {
        didSet {
            guard oldValue != self.selectionState, self.alreadyUpdateAll else { return }

            self.setDynamicColors()
            self.setIsIcon()
        }
    }

    // MARK: - Use Case Properties

    private let getColorsUseCase: CheckboxGetColorsUseCaseable
    private let getIsIconUseCase: CheckboxGetIsIconUseCaseable

    // MARK: - Initialization

    init(
        getColorsUseCase: CheckboxGetColorsUseCaseable = CheckboxGetColorsUseCase(),
        getIsIconUseCase: CheckboxGetIsIconUseCaseable = CheckboxGetIsIconUseCase()
    ) {
        self.getColorsUseCase = getColorsUseCase
        self.getIsIconUseCase = getIsIconUseCase

        super.init(type: .checkbox)
    }

    // MARK: - Setup

    func setup(
        theme: Theme,
        intent: CheckboxIntent,
        selectionState: CheckboxSelectionState,
        isEnabled: Bool,
        isCustomLabel: Bool
    ) {
        self.intent = intent
        self.selectionState = selectionState

        self.setup(
            theme: theme,
            isEnabled: isEnabled,
            isCustomLabel: isCustomLabel
        )

        self.setDynamicColors()
        self.setStaticColors()
        self.setIsIcon()

        self.alreadyUpdateAll = true
    }

    // MARK: - Private Setter

    private func setDynamicColors() {
        guard let theme, let intent, let selectionState else {
            return
        }

        self.dynamicColors = self.getColorsUseCase.executeDynamic(
            theme: theme,
            intent: intent,
            selectionState: selectionState
        )
    }

    private func setStaticColors() {
        guard let theme, let intent else {
            return
        }

        self.staticColors = self.getColorsUseCase.executeStatic(
            theme: theme,
            intent: intent
        )
    }

    private func setIsIcon() {
        guard let selectionState else {
            return
        }

        self.isIcon = self.getIsIconUseCase.execute(
            selectionState: selectionState
        )
    }
}
