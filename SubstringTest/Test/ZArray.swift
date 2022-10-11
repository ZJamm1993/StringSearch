//
//  ZArray.swift
//  SubstringTest
//
//  Created by zjj on 2021/8/31.
//

import Foundation

struct ZArray: StringSearch {
    
    func index(for pattern: [Element], in text: [Element]) -> Int? {
        let pst = pattern + ["$"] + text
        let l = pst.count
        let z = getZArray(for: pst)
        let pLen = pattern.count
        for i in stride(from: 0, to: l, by: 1) {
            if z[i] == pLen {
                return i - pLen - 1
            }
        }
        return nil
    }
    
    func getZArray(for string: [Element]) -> [Int] {
        let cnt = string.count
        if cnt == 0 {
            return []
        }
        
        var z = [Int](repeating: 0, count: cnt)
        let n = cnt
        var L = 0, R = 0
        for i in stride(from: 1, to: n, by: 1) {
            if i > R {
                L = i
                R = i
                while R < n && string[R - L] == string[R] {
                    R += 1
                }
                z[i] = R - L
                R -= 1
            }
            else {
                let k = i - L
                if z[k] < R - i + 1 {
                    z[i] = z[k]
                } else {
                    L = i
                    while R < n && string[R - L] == string[R] {
                        R += 1
                    }
                    z[i] = R - L
                    R -= 1
                }
            }
        }
        return z
    }
}
