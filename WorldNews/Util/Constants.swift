//
//  Constants.swift
//  WorldNews
//
//  Created by Arman Merchant on 04/12/21.
//

import Foundation

enum RegEx{
    static let email    = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let password = ".{6,}"
    static let name     = ".{2,}"
}

struct FirestoreKeys {
    static let matches = "matches"
}


enum MatchType: Int{
    case oneday = 0
    case t20 = 1
    case test = 2
}
