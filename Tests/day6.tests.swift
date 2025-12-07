//
//  day6.tests.swift
//  AOC25
//
//  Created by Snow Kit on 07/12/2025.
//
import Foundation
import Testing
import AOC25

@Suite("Day 6") struct Day6Tests {
    static let example =
      "123 328  51 64 \n"
    + " 45 64  387 23 \n"
    + "  6 98  215 314\n"
    + "*   +   *   +  \n"
    
    static let data = Array(example.utf8)
    
    
    @Test("Validate d6p1 from example")
    func p1() {
        let day = try! Day6(data: Day6Tests.data)
        #expect(day.part1() == "4277556")
    }
    
    @Test("Validate d6p2 from example")
    func p2() {
        let day = try! Day6(data: Day6Tests.data)
        #expect(day.part2() == "3263827")
    }
}
