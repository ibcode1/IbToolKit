//
//  IbFontName.swift
//  IbTools
//
//  Created by Ibrahim fuseini on 16/12/2024.
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
