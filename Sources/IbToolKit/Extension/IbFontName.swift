//
//  IbFontName.swift
//  IbToolKit
//
//  Created by Ibrahim fuseini on 10/12/2025.
//

import Foundation

public enum IbFontName: String, CaseIterable {

    // Lexend styles
    case lexendThin     = "Lexend-Thin"
    case lexendMedium   = "Lexend-Medium"
    case lexendBold     = "Lexend-Bold"

    var requiresRegistration: Bool {
        switch self {
        case .lexendThin, .lexendMedium, .lexendBold: true
        }
    }
}
