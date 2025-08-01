//
//  View+SensoryFeedbackExtension.swift
//  SparkComponentSelectionControls
//
//  Created by robin.lemaire on 29/07/2025.
//  Copyright © 2025 Leboncoin. All rights reserved.
//

import SwiftUI

extension View {

    @ViewBuilder
    func sensoryFeedback<T>(trigger: T) -> some View where T: Equatable {
        if #available(iOS 17.0, *) {
            self.sensoryFeedback(.impact, trigger: trigger)
        } else {
            self
        }
    }
}
