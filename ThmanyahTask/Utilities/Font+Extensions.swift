//
//  Font+Extensions.swift
//  ThmanyahTask
//
//  Created by iSlam AbdelAziz on 09/08/2025.
//

import SwiftUI

enum AppCustomFont {
    case largeTitle
    case title
    case title2
    case body
    case caption
    
    var size: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title:      return 24
        case .title2:      return 20
        case .body:       return 16
        case .caption:    return 12
        }
    }
    
    var relativeTo: Font.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title:      return .title
        case .title2:      return .title2
        case .body:       return .body
        case .caption:    return .caption
        }
    }
}

enum AppCustomFontWeight: String {
    case bold = "Bold"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semibold = "Semibold"
    case text = "Text"
    case thin = "Thin"
}

extension View {
    func appFont(_ style: AppCustomFont, weight: AppCustomFontWeight = .regular) -> some View {
        self.font(.custom("IBMPlexSansArabic-\(weight.rawValue)",
                          size: style.size,
                          relativeTo: style.relativeTo))
    }
}
