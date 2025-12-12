//
//  FontViewModel.swift
//  IbTools
//
//  Created by Ibrahim fuseini on 16/12/2024.
//

import Observation

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
