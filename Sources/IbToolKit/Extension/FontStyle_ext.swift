//
//  FontStyle_ext.swift
//
//
//  Created by Ibrahim fuseini on 06/06/2024.
//

import IbFoundation
import SwiftUI

// swiftlint:disable identifier_name
public enum IbFontStyle {

    case h2
    case h3
    case h4

    case h5
    case h5Light
    case h5Bold

    case body
    case bodyLight
    case bodyBold

    case caption
    case captionLight
    case captionBold

    case tiny

    public var name: String { String(describing: self) }

    public func description(for family: IbFontFamily) -> String {
        "\(fontName(for: family).rawValue) (\(size)pt)"
    }

    private func fontName(for family: IbFontFamily) -> IbFontName {
        switch self {
        case .h2, .h3, .h4, .h5Bold, .bodyBold, .captionBold:
            switch family {
            case .lexend: .lexendBold
            }

        case .h5, .body, .caption, .tiny:
            switch family {
            case .lexend: .lexendMedium
            }

        case .h5Light, .bodyLight, .captionLight:
            switch family {
            case .lexend: .lexendThin
            }
        }
    }

    private var size: CGFloat {
        switch self {
        case .h2:           34.0
        case .h3:           28.0
        case .h4:           20.0

        case .h5:           16.0
        case .h5Light:      16.0
        case .h5Bold:       16.0

        case .body:         13.0
        case .bodyLight:    13.0
        case .bodyBold:     13.0

        case .caption:      12.0
        case .captionLight: 12.0
        case .captionBold:  12.0

        case .tiny:         10.0
        }
    }

    private var relativeTo: Font.TextStyle {
        switch self {
        case .h2:           .largeTitle
        case .h3:           .title
        case .h4:           .title3

        case .h5:           .headline
        case .h5Light:      .headline
        case .h5Bold:       .headline

        case .body:         .footnote
        case .bodyLight:    .footnote
        case .bodyBold:     .footnote

        case .caption:      .caption
        case .captionLight: .caption
        case .captionBold:  .caption

        case .tiny:         .caption2
        }
    }

    public func components(for family: IbFontFamily) -> FontComponents {

        let fontName = fontName(for: family)
        return FontComponents(fontName: fontName, size: size, relativeTo: relativeTo)
    }
}

// swiftlint:enable identifier_name

public extension Font {

    static func ibFont(
        _ style: IbFontStyle,
        fontFamily: IbFontFamily = .lexend,
        useScaledFont: Bool = true,
        fontViewModel: FontViewModel = FontViewModel()
    ) -> Font {

        fontViewModel.registerFonts()

        let components = style.components(for: fontFamily)

        return useScaledFont
        ? .custom(components.fontName.rawValue, size: components.size, relativeTo: components.relativeTo)
        : .custom(components.fontName.rawValue, fixedSize: components.size)
    }
}
