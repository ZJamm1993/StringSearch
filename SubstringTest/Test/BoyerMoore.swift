//
//  BoyerMoore.swift
//  SubstringTest
//
//  Created by zjj on 2021/9/2.
//

import Foundation

// 仅使用了“坏字符”规则
// “好后缀”暂未研究明白

struct BoyerMoore: StringSearch {
    
    func index(for pattern: [Element], in text: [Element]) -> Int? {
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
    
    private func charsLastIndexes(for pattern: [Element]) -> [Element: Int] {
        var dic = [Element: Int]()
        for (i, c) in pattern.enumerated() {
            dic[c] = i
        }
        return dic
    }
}
