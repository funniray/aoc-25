//
//  day4.tests.swift
//  AOC25
//
//  Created by Snow Kit on 04/12/2025.
//
import Foundation
import Testing
import AOC25

@Suite("Day 4") struct Day4Tests {
    static let example = 
      "..@@.@@@@.\n"
    + "@@@.@.@.@@\n"
    + "@@@@@.@.@@\n"
    + "@.@@@@..@.\n"
    + "@@.@@@@.@@\n"
    + ".@@@@@@@.@\n"
    + ".@.@.@.@@@\n"
    + "@.@@@.@@@@\n"
    + ".@@@@@@@@.\n"
    + "@.@.@@@.@."
    
    static let data = Array(example.utf8)
    
    @Test("Validate d4p1 from example")
    func p1() {
        let day = try! Day4(data: Day4Tests.data)
        #expect(day.part1() == "13")
    }
    
    @Test("Validate d4p2 from example")
    func p2() {
        let day = try! Day4(data: Day4Tests.data)
        #expect(day.part2() == "43")
    }
}
