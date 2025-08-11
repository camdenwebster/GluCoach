//
//  GluCoachApp.swift
//  GluCoach
//
//  Created by Camden Webster on 8/8/25.
//

import SwiftUI

@main
struct GluCoachApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

import FoundationModels

struct AvailabilityView: View {
    private var model = SystemLanguageModel.default
    
    var body: some View {
        switch model.availability {
        case .available:
            ContentView()
        case .unavailable(.modelNotReady):
            ContentUnavailableView("Apple Intelligence is not ready. Please try again later.", systemImage: "apple.intelligence")
        case .unavailable(.appleIntelligenceNotEnabled):
            ContentUnavailableView("Apple Intelligence is not enabled on this device. Please enable Apple Intelligence to use GluCoach.", systemImage: "apple.intelligence")
        case .unavailable(.deviceNotEligible):
            ContentUnavailableView("This device does not support Apple Intelligence.", systemImage: "apple.intelligence")
        case .unavailable(let other):
            ContentUnavailableView("an unknown error occurred.", systemImage: "exclamationmark.triangle")
        }
    }
}
