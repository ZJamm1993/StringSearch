//
//  main.swift
//  SubstringTest
//
//  Created by zjj on 2021/8/31.
//

import Foundation

extension StringSearch {
    func test(pattern: [Element], text: [Element]) -> TestResult {
        let start = Date.timeIntervalSinceReferenceDate
        print("start", self)
        let index = self.index(for: pattern, in: text) ?? -1
        let end = Date.timeIntervalSinceReferenceDate
        let interval = end - start
        if index == -1 {
            print("WHAT ERROR??")
        }
        print("time:", String(format: "%.06f", interval), "res:", index )
        return TestResult(type: self, time: interval, index: index )
    }
}

struct TestResult {
    let type: Any
    let time: TimeInterval
    let index: Int
}

let randomChars: [Character] = ["A", "C", "G", "T"]
let randomChars2: [Character] = ["A", "C", "G", "T", "U", "1", "2", "3", "4"]

var winTimes: [String: Int] = [:]

for _ in 0 ..< 100 {
    print("Building Text and Pattern...")
    var pattern: [Character] = []
    for _ in 0 ..< 100 {
        let c = randomChars.randomElement() ?? "A"
        pattern.append(c)
    }
    
    var text: [Character] = []
    for _ in 0 ..< 100000 {//000 {
        let c = randomChars2.randomElement() ?? "A"
        text.append(c)
    }
    text.insert(contentsOf: pattern, at: Int.random(in: 0..<text.count))
    
//    let pattern = "EXAMPLE".elements
//    let text = "HERE IS A SIMPLE EXAMPLE".elements
    
    let testTypes: [any StringSearch] = [
        BoyerMoore(),
        Sunday(),
        KMP(),
        Naive(),
//        ZArray<Character>(),
    ]
    var results = [TestResult]()
    for type in testTypes {
        let time = type.test(pattern: pattern, text: text)
        results.append(time)
    }
    let winner = results.min { res1, res2 in
        return res1.time < res2.time
    }
    let key = "\(winner!.type)"
    winTimes[key, default: 0] += 1
    
    let allRes = Set(results.compactMap { res in
        return res.index
    })
    if allRes.count != 1 {
        print("WHO DID WRONG")
    }
    print("<<<< winner:", winner!.type, ">>>>", "\n")
}

print(winTimes)
