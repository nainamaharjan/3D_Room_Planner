//
//  AttributedString.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import UIKit

extension NSMutableAttributedString {
    
    func trimmedAttributedString(set: CharacterSet) -> NSMutableAttributedString {
        let invertedSet = set.inverted
        var range = (string as NSString).rangeOfCharacter(from: invertedSet)
        let loc = range.length > 0 ? range.location : 0
        range = (string as NSString).rangeOfCharacter(
            from: invertedSet, options: .backwards)
        let length = (range.length > 0 ? NSMaxRange(range) : string.count) - loc
        let attributedString = self.attributedSubstring(from: NSMakeRange(loc, length))
        return NSMutableAttributedString(attributedString: attributedString)
    }
    
    func htmlAttributedString() -> NSMutableAttributedString {
        let info = "<span>\(self)</span>"
        guard let data = info.data(using: String.Encoding.utf8, allowLossyConversion: false)
        else { return NSMutableAttributedString() }
        
        guard let formattedString = try? NSMutableAttributedString(data: data,
                                                                   options: [.documentType: NSAttributedString.DocumentType.html,
                                                                             .characterEncoding: String.Encoding.utf8.rawValue],
                                                                   documentAttributes: nil )
                
        else { return NSMutableAttributedString() }
        
        return formattedString.trimmedAttributedString(set: .whitespacesAndNewlines)
    }
    
    func with(font: UIFont, textColor: UIColor = .black) -> NSMutableAttributedString {
        self.enumerateAttribute(NSAttributedString.Key.font, in: NSMakeRange(0, self.length), options: .longestEffectiveRangeNotRequired, using: { (value, range, _) in
            guard let originalFont = value as? UIFont else { return  }
            if let newFont = applyTraitsFromFont(originalFont, to: font) {
                self.addAttribute(NSAttributedString.Key.font, value: newFont, range: range)
                self.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
                
            }
        })
        return self
    }
    func with(textColor: UIColor = .black) -> NSMutableAttributedString {
        self.enumerateAttribute(NSAttributedString.Key.font, in: NSMakeRange(0, self.length), options: .longestEffectiveRangeNotRequired, using: { (value, range, _) in
            guard let originalFont = value as? UIFont else { return  }
            self.addAttribute(NSAttributedString.Key.font, value: originalFont, range: range)
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
            
        })
        return self
    }
    
    func applyTraitsFromFont(_ firstFont: UIFont, to secondFont: UIFont) -> UIFont? {
        let originalTrait = firstFont.fontDescriptor.symbolicTraits
        if originalTrait.contains(.traitBold) {
            var traits = secondFont.fontDescriptor.symbolicTraits
            traits.insert(.traitBold)
            if let newFont = secondFont.fontDescriptor.withSymbolicTraits(traits) {
                return UIFont.init(descriptor: newFont, size: 0)
            }
        }
        return secondFont
    }
    
}
