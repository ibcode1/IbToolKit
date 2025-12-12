//
//  Text_ext.swift
//  IbTools
//
//  Created by Ibrahim fuseini on 16/12/2024.
//

import SwiftUI

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
