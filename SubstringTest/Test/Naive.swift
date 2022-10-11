//
//  Brute.swift
//  SubstringTest
//
//  Created by zjj on 2021/8/31.
//

import Foundation

struct Naive: StringSearch {
    
    func index(for pattern: [Element], in text: [Element]) -> Int? {
        guard self.shouldStartSearch(pattern: pattern, text: text) else {
            return nil
        }
        let pLen = pattern.count
        let tLen = text.count
        var s = 0
        
        while s <= (tLen - pLen) {
            var j = 0
            while j < pLen && pattern[j] == text[s + j] {
                j += 1
            }
            if j >= pLen {
                return s
            } else {
                s += 1
            }
        }
        return nil
    }
}
