//
//  Utils.swift
//  Music
//
//  Created by Albert on 14.07.2022.
//

import Foundation
import SwiftUI
import MusicKit

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

extension Formatter {
    static let positional: DateComponentsFormatter = {
        let positional = DateComponentsFormatter()
        positional.unitsStyle = .positional
        positional.zeroFormattingBehavior = .pad
        return positional
    }()
}

extension TimeInterval {
    var positionalTime: String {
        Formatter.positional.allowedUnits = self >= 3600 ?
        [.hour, .minute, .second] :
        [.minute, .second]
        let string = Formatter.positional.string(from: self)!
        return string.hasPrefix("0") && string.count > 4 ?
            .init(string.dropFirst()) : string
    }
}

extension Artwork {
    
    var bgColor: Color {
        return Color(cgColor: backgroundColor ?? .defaultColor)
    }
    
    var textColor: Color {
        return Color(cgColor: primaryTextColor ?? .defaultColor)
    }
    
    var secondTextColor: Color {
        return Color(cgColor: secondaryTextColor ?? .defaultColor)
    }
}

extension CGColor {
    static var defaultColor: CGColor {
        return .init(gray: 0, alpha: 0)
    }
}
