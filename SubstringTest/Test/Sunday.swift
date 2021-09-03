//
//  Sunday.swift
//  SubstringTest
//
//  Created by zjj on 2021/9/3.
//

import Foundation

enum Sunday: StringSearch {
    static func index<T>(for pattern: [T], in text: [T]) -> Int? where T: Element {
        guard self.shouldStartSearch(pattern: pattern, text: text) else {
            return nil
        }
        let pLen = pattern.count
        let tLen = text.count
        
        let charTable = charsLastIndexes(for: pattern)
        // the begin shift
        var s = 0
        while s <= (tLen - pLen) {
            var j = 0
            // 从前往后比（与BM不同）
            while j < pLen && pattern[j] == text[s + j] {
                j += 1
            }
            if j >= pLen {
                return s
            } else {
                let targetI = s + pLen
                // 类似于BM的坏字符串规则，但关注点是text[s + pLen]，而不是当前失配字符text[s + j]
                if targetI < tLen {
                    if let lastIndex = charTable[text[targetI]] {
                        s += pLen - lastIndex
                    } else {
                        s += pLen + 1
                    }
                } else {
                    s = tLen
                    // text走完了，结束
                }
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
