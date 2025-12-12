//
//  IbFontViewModifier.swift
//  IbTools
//
//  Created by Ibrahim fuseini on 16/12/2024.
//

import SwiftUI

public struct IbFontViewModifier: ViewModifier {

    let components: FontComponents
    var isScaled: Bool = true

    public func body(content: Content) -> some View {
        content
            .font(
                isScaled ? .custom(
                    components.fontName.rawValue,
                    size: components.size,
                    relativeTo: components.relativeTo
                ) : .custom(
                    components.fontName.rawValue,
                    fixedSize: components.size
                )
        )
    }
}
