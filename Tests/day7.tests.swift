//
//  day7.tests.swift
//  AOC25
//
//  Created by Snow Kit on 07/12/2025.
//

import Foundation
import Testing
import AOC25

@Suite("Day 7") struct Day7Tests {
    static let example =
      ".......S.......\n"
    + "...............\n"
    + ".......^.......\n"
    + "...............\n"
    + "......^.^......\n"
    + "...............\n"
    + ".....^.^.^.....\n"
    + "...............\n"
    + "....^.^...^....\n"
    + "...............\n"
    + "...^.^...^.^...\n"
    + "...............\n"
    + "..^...^.....^..\n"
    + "...............\n"
    + ".^.^.^.^.^...^.\n"
    + "...............\n"
    
    static let data = Array(example.utf8)
    
    
    @Test("Validate d7p1 from example")
    func p1() {
        let day = try! Day7(data: Day7Tests.data)
        #expect(day.part1() == "21")
    }
    
    @Test("Validate d7p12 from example")
    func p2() {
        let day = try! Day7(data: Day7Tests.data)
        #expect(day.part2() == "40")
    }
    
}
