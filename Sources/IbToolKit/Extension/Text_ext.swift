//
//  Text_ext.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 10/12/2025.
//

import SwiftUI

@MainActor
public extension Text {

    @ViewBuilder
    func ibFont(
        _ style: IbFontStyle,
        fontFamily: IbFontFamily = .lexend,
        useScaledFont: Bool = true
    ) -> Text {

        self.font(Font.ibFont(style, fontFamily: fontFamily, useScaledFont: useScaledFont))
    }
}
