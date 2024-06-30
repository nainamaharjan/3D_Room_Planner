//
//  Encodable.swift
//  BigFanzBusiness
//
//  Created by Maharjan on 14/01/2023.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        var dataDic =  (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        guard dataDic != nil else {return nil}
        for (key,value) in dataDic! {
            if let strValue = (value as? String), strValue.isEmpty {
                dataDic![key] = ""
            }
        }
        return dataDic
    }
}
