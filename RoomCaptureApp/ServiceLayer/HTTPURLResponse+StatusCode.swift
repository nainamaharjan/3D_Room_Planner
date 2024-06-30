//
//  HTTPURLResponse.swift
//  anydone_inbox
//
//  Created by Naina Maharjan on 9/28/21.
//

import Foundation

extension HTTPURLResponse {
    
    private static var OK200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK200
    }
    
}
