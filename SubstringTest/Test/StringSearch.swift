//
//  StringSearch.swift
//  SubstringTest
//
//  Created by zjj on 2021/8/31.
//

import Foundation

extension String {
    var elements: [Character] {
        let chars = Array(self)
//        .map { char in
//            return char.hashValue
//        }
        return chars
    }
}

protocol StringSearch {
    typealias Element = Hashable
    static func index<T: Element>(for pattern: [T], in text: [T]) -> Int?
}

extension StringSearch {
    static func shouldStartSearch<T>(pattern: [T], text: [T]) -> Bool {
        let pLen = pattern.count
        guard pLen > 0 else {
            return false
        }
        let tLen = text.count
        guard tLen > 0 else {
            return false
        }
        guard pLen <= tLen else {
            return false
        }
        return true
    }
}
