//
//  View_ext.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 10/12/2025.
//

import SwiftUI

public extension View {

    @ViewBuilder
    func ibFont(
        _ style: IbFontStyle,
        fontFamily: IbFontFamily = .lexend,
        useScaledFont: Bool = true
    ) -> some View {

        self.modifier(IbFontViewModifier(components: style.components(for: fontFamily), isScaled: useScaledFont))
    }
}
