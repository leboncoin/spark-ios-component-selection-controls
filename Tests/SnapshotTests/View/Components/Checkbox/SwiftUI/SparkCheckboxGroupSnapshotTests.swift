//
//  SparkCheckboxGroupSnapshotTests.swift
//  SparkComponentSelectionControlsSnapshotTests
//
//  Created by robin.lemaire on 11/09/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import SparkComponentSelectionControls
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkThemingTesting
import SparkTheming
import SparkTheme
import SwiftUI

final class SparkCheckboxGroupSnapshotTests: SwiftUIComponentSnapshotTestCase {

    // MARK: - Properties

    private let theme: any Theme = SparkTheme.shared

    // MARK: - Tests

    func test() throws {
        let forDocumentation = false

        let scenarios = CommonGroupScenarioSnapshotTests.allCases(forDocumentation: forDocumentation)

        for scenario in scenarios {
            let configurations: [CommonGroupConfigurationSnapshotTests] = try scenario.configuration()

            for configuration in configurations {
                let view = SparkCheckboxGroup(
                    theme: self.theme,
                    selectedIDs: .constant([1]),
                    items: .allCases(contentResilience: configuration.content),
                    selectedIcon: .selected
                )
                    .sparkCheckboxGroupAxis(configuration.axis)
                    .sparkCheckboxIntent(configuration.intent)
                    .disabled(!configuration.status.isEnabled)
                    .style(
                        forDocumentation: forDocumentation,
                        useLargePadding: true
                    )

                self.assertSnapshot(
                    matching: view,
                    modes: configuration.modes,
                    sizes: configuration.sizes,
                    testName: configuration.testName()
                )
            }
        }
    }
}

// MARK: - Extension

private extension Image {
    static var selected = Image(uiImage: IconographyTests.shared.checkmark)
}
