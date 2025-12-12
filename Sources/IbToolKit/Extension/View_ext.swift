//
//  View_ext.swift
//  IbTools
//
//  Created by Ibrahim fuseini on 16/12/2024.
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
