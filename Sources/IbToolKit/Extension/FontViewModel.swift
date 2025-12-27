//
//  FontViewModel.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 10/12/2025.
//

import Observation

@MainActor
@Observable
public class FontViewModel {

    public let fontManager: FontManager

    public init(fontManager: FontManager = FontManager()) {
        self.fontManager = fontManager
    }

    public func registerFonts() {
        fontManager.registerCustomFonts()
    }
}
