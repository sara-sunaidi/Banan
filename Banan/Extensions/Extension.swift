//
//  Extensions.swift
//  Banan
//
//  Created by Sara Alsunaidi on 12/03/2022.
//

import Foundation

public extension String {
    private static let formatter = NumberFormatter()

    /// Converts any digit in any language represented in the string and returns the converted string.
    /// - Parameter locale: Destination locale.
    /// - Returns: Converted string.
//    private static let formatter = NumberFormatter()

        func clippingCharacters(in characterSet: CharacterSet) -> String {
            components(separatedBy: characterSet).joined()
        }

        func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
            let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
            guard !digits.isEmpty else { return self }

            Self.formatter.locale = locale

            let maps: [(original: String, converted: String)] = digits.map {
                let original = String($0)
                let digit = Self.formatter.number(from: original)!
                let localized = Self.formatter.string(from: digit)!
                return (original, localized)
            }

            return maps.reduce(self) { converted, map in
                converted.replacingOccurrences(of: map.original, with: map.converted)
            }
        }
    
//    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
//        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
//        guard !digits.isEmpty else { return self }
//
//        Self.formatter.locale = locale
//        /// Find all digits and build a map table for them.
//        let maps: [(original: String, converted: String)] = digits.map {
//            let original = String($0)
//            // NumberFormatter can always create a number form decimalDigits characterSet. No need for check.
//            let digit = Self.formatter.number(from: original)!
//
//            // A digit that created from a string can always convert back to string. No need for check.
//            let localized = Self.formatter.string(from: digit)!
//            return (original, localized)
//        }
//
//        return maps.reduce(self) { converted, map in
//            converted.replacingOccurrences(of: map.original, with: map.converted)
//        }
    }

    /// Converts any digit in any language represented in the string and returns the converted string.
    /// - Parameter identifier: Destination locale identifier.
    /// - Returns: Converted string.
//    func convertedDigitsToLocale(identifier: String = Locale.current.identifier) -> String {
//        convertedDigitsToLocale(Locale(identifier: identifier))
//    }
//}
