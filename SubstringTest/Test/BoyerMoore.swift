//
//  BoyerMoore.swift
//  SubstringTest
//
//  Created by zjj on 2021/9/2.
//

import Foundation

// 仅使用了“坏字符”规则
// “好后缀”暂未研究明白

enum BoyerMoore: StringSearch {
    static func index<T>(for pattern: [T], in text: [T]) -> Int? where T: Element {
        guard self.shouldStartSearch(pattern: pattern, text: text) else {
            return nil
        }
        let pLen = pattern.count
        let tLen = text.count
        
        let badCharIndex = charsLastIndexes(for: pattern)
        // the begin shift
        var s = 0
        while s <= (tLen - pLen) {
            var j = pLen - 1
            while j >= 0 && pattern[j] == text[s + j] {
                j -= 1
            }
            if j < 0 {
                return s
            } else {
                let badchar = badCharIndex[text[s + j]] ?? -1
                let nextDelta = max(1, j - badchar)
                s += nextDelta
            }
        }
        return nil
    }
    
    private static func charsLastIndexes<T>(for pattern: [T]) -> [T: Int] where T: Element {
        var dic = [T: Int]()
        for (i, c) in pattern.enumerated() {
            dic[c] = i
        }
        return dic
    }
}
