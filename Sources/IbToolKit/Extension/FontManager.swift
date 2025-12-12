//
//  FontManager.swift
//  IbTools
//
//  Created by Ibrahim fuseini on 16/12/2024.
//

import IbFoundation
import UIKit

// MARK: - FontManager class

/// A utility that registers custom TrueType fonts (.ttf) bundled with the module at runtime.
///
/// FontManager scans the set of known font names (from `IbFontName`) and registers only those
/// that indicate they require registration. Registration is performed once per process: repeated
/// calls to `registerCustomFonts()` are unchanged.
///
/// This manager expects the font files to be included in the Swift package/module resources
/// with `.ttf` extensions and filenames matching the `rawValue` of each `IbFontName` case.
///
/// Usage:
/// ```swift
/// let fontManager = FontManager()
/// fontManager.registerCustomFonts()
/// // After registration, UIFont(name: "...", size: ...) can resolve the custom fonts.
/// ```
///
/// Notes:
/// - Registration uses `CTFontManagerRegisterFontsForURL(_:_:_:)` with the `.process` scope,
///   making the fonts available to the current process only.
/// - If a font is already registered (by this process), CoreText will treat re-registration as a no-op.
/// - Ensure your package manifest lists the fonts as resources so `Bundle.module` can locate them.
///
/// Thread-safety:
/// - `registerCustomFonts()` flips an internal flag to prevent duplicate work and is safe to call
///   from the main thread during app startup (e.g., in `AppDelegate` or app initialization).
public class FontManager {

  /// Creates a new font manager.
  public init() {}

  /// Tracks whether custom fonts have already been registered for the current process.
  ///
  /// This flag ensures that `registerCustomFonts()` performs work only once per instance.
  private var didRegisterCustomFonts: Bool = false

  /// Registers all custom fonts that require registration.
  ///
  /// This method:
  /// - Checks the `didRegisterCustomFonts` flag and returns immediately if fonts were already registered.
  /// - Filters `IbFontName.allCases` to those with `requiresRegistration == true`.
  /// - Attempts to register each corresponding `.ttf` file from `Bundle.module`.
  ///
  /// Fonts that cannot be found or fail to register will be logged to the console.
  ///
  /// Idempotency:
  /// - Safe to call multiple times; subsequent calls will return early after the first successful call.
  public func registerCustomFonts() {

    guard didRegisterCustomFonts == false else { return }
    didRegisterCustomFonts = true

    let fontsRequiringRegistration = IbFontName.allCases.filter { $0.requiresRegistration }

    for font in fontsRequiringRegistration {
      registerFont(named: font.rawValue)
    }
  }

  /// Registers a single TrueType font by filename (without extension) from the module bundle.
  ///
  /// - Parameter fontName: The base filename of the font (without `.ttf`), typically `IbFontName.rawValue`.
  ///
  /// Looks up `<fontName>.ttf` in `Bundle.module` and registers it using CoreText for the current process.
  /// If the file cannot be located or CoreText registration fails, a message is printed to the console.
  private func registerFont(named fontName: String) {

    guard
      let url = Bundle.module.url(forResource: fontName, withExtension: "ttf"),
      CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    else {

      print("FontManager: Unable to register font '\(fontName)'. Ensure '\(fontName).ttf' is included in package resources.")
      return
    }
  }
}
