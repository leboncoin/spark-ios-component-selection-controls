//
//  ToggleConfigurationSnapshotTests.swift
//  SparkSelectionControlsSnapshotTests
//
//  Created by robin.lemaire on 09/10/2024.
//  Copyright © 2023 Leboncoin. All rights reserved.
//

@testable import SparkSelectionControls
@_spi(SI_SPI) import SparkCommonSnapshotTesting
@_spi(SI_SPI) import SparkCommon
import XCTest

struct ToggleConfigurationSnapshotTests {

    // MARK: - Type Alias

    private typealias Constants = ComponentSnapshotTestConstants

    // MARK: - Properties

    let scenario: ToggleScenarioSnapshotTests

    let value: ToggleValue
    let status: ToggleStatus
    let content: ToggleContentResilience

    let modes: [ComponentSnapshotTestMode]
    let sizes: [UIContentSizeCategory]

    // MARK: - Initialization

    init(
        scenario: ToggleScenarioSnapshotTests,
        value: ToggleValue,
        status: ToggleStatus,
        content: ToggleContentResilience,
        modes: [ComponentSnapshotTestMode] = Constants.Modes.default,
        sizes: [UIContentSizeCategory] = Constants.Sizes.default
    ) {
        self.scenario = scenario
        self.value = value
        self.status = status
        self.content = content
        self.modes = modes
        self.sizes = sizes
    }

    // MARK: - Getter

    func testName() -> String {
        return [
            "\(self.scenario.rawValue)",
            "\(value)" + "Value",
            "\(status)" + "Status",
            "\(content)" + "Content"
        ].joined(separator: "-")
    }
}

// MARK: - Enum

enum ToggleValue: String, CaseIterable {
    case activated
    case deactivated

    var isOn: Bool {
        switch self {
        case .activated: true
        case .deactivated: false
        }
    }
}

enum ToggleStatus: String, CaseIterable {
    case enabled
    case disabled

    var isEnabled: Bool {
        switch self {
        case .enabled: true
        case .disabled: false
        }
    }
}

enum ToggleContentResilience: String, CaseIterable {
    case withoutLabel
    case shortLabel
    case multilineLabel
    case other

    var text: String? {
        switch self {
        case .withoutLabel: nil
        case .shortLabel: "My switch"
        case .multilineLabel: "My switch. Lorem ipsum dolor.\nConsectetur adipiscing elit.\nProin vel metus pretium."
        case .other: nil
        }
    }
}
