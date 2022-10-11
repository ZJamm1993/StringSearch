//
//  KMP.swift
//  SubstringTest
//
//  Created by zjj on 2021/8/31.
//

import Foundation

// 不知道是不是写错了，好慢好慢

struct KMP: StringSearch {
    
    func index(for pattern: [Element], in text: [Element]) -> Int? {
        guard self.shouldStartSearch(pattern: pattern, text: text) else {
            return nil
        }
        
        let pLen = pattern.count
        let tLen = text.count
        var pi = 0
        var ti = 0
        
        let nexts = getNexts(pattern: pattern)
        
        let lenDelta = tLen - pLen
        while pi < pLen && ti - pi <= lenDelta {
            if pi < 0 || pattern[pi] == text[ti] {
                pi += 1
                ti += 1
            } else {
                pi = nexts[pi]
            }
        }
//        print(compareCount)
        return pi == pLen ? ti - pi : nil
        
        
        /*
        let pLen = pattern.count
        let tLen = text.count
        let nexts = getNexts(pattern: pattern)
        var s = 0
        
        while s <= (tLen - pLen) {
            var j = 0
            while j < pLen && pattern[j] == text[s + j] {
                j += 1
            }
            if j >= pLen {
                return s
            } else {
                let delta = max(1, nexts[j])
                s += delta
            }
        }
        return nil
 */
    }
    
    private func getNexts(pattern: [Element]) -> [Int] {
        let len = pattern.count
        var nexts = [Int](repeating: 0, count: len)
        nexts[0] = -1
        var i = 0
        var n = -1
        let imax = len - 1
        while i < imax {
            if n < 0 || pattern[i] == pattern[n] {
                i += 1
                n += 1
//                nexts[i] = n
                if pattern[i] == pattern[n] {
                    nexts[i] = nexts[n]
                } else {
                    nexts[i] = n
                }
            } else {
                n = nexts[n]
            }
        }
        return nexts
    }
}
