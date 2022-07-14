//
//  Utils.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import SwiftUI

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

extension Color {
    static let buttonColor = Color("ButtonColor")
    static let backgroundColor = Color("BackgroundColor")
}
