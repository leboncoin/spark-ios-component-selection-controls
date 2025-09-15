//
//  TransactionViewModifier.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 29/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI

struct TransactionViewModifier: ViewModifier {

    // MARK: - Properties

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // MARK: - Initialization

    func body(content: Content) -> some View {
        content
            .transaction {
                if self.reduceMotion {
                    $0.animation = nil
                }
            }
    }
}

// MARK: - Extension

extension View {

    func transaction() -> some View {
        self.modifier(TransactionViewModifier())
    }
}
