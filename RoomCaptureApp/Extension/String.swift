//
//  String.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import UIKit

extension String {

    func htmlAttributedString() -> NSMutableAttributedString {
        let info = "<span>\(self)</span>"
        guard let data = info.data(using: String.Encoding.utf8, allowLossyConversion: false)
        else { return NSMutableAttributedString() }
        
        guard let formattedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        
        else { return NSMutableAttributedString() }
        
        return formattedString.trimmedAttributedString(set: .whitespacesAndNewlines)
    }
    
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func detectUrl() -> String? {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
            for match in matches {
                guard let range = Range(match.range, in: self) else { continue }
                let url = self[range]
                return String(describing: url)
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func getUniqueKey() -> String{
        return UUID.init().uuidString.removeDash()
    }
    
    func removeDash() -> String {
        self.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil)
    }
    
    
    // Slice a string using index range
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }
}
