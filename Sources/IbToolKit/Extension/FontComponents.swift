//
//  FontComponents.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 10/12/2025.
//

import SwiftUI

public struct FontComponents {

    public let fontName: IbFontName
    public let size: CGFloat
    public let relativeTo: Font.TextStyle

    public init(  //why init this struct?
        fontName: IbFontName,
        size: CGFloat,
        relativeTo: Font.TextStyle
    ) {

        self.fontName = fontName
        self.size = size
        self.relativeTo = relativeTo
    }
}
