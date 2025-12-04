//
//  day1.tests.swift
//  AOC25
//
//  Created by Snow Kit on 02/12/2025.
//
import Foundation
import Testing
import AOC25

@Suite("Day 1") struct Day1Tests {
    static let example = "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"
    static let data = Array(example.utf8)
    
    @Test("Validate d1p1 from example")
    func p1() {
        let day = try! Day1(data: Day1Tests.data)
        #expect(day.part1() == "3")
    }
    
    @Test("Validate d1p2 from example")
    func p2() {
        let day = try! Day1(data: Day1Tests.data)
        #expect(day.part2() == "6")
    }
}
