//
//  day5.tests.swift
//  AOC25
//
//  Created by Snow Kit on 05/12/2025.
//
import Foundation
import Testing
import AOC25


@Suite("Day 5") struct Day5Tests {
    static let example =
      "3-5\n"
    + "10-14\n"
    + "16-20\n"
    + "12-18\n"
    + "\n"
    + "1\n"
    + "5\n"
    + "8\n"
    + "11\n"
    + "17\n"
    + "32\n"
    
    static let data = Array(example.utf8)
    
    
    @Test("Validate d5p1 from example")
    func p1() {
        let day = try! Day5(data: Day5Tests.data)
        #expect(day.part1() == "3")
    }
    
    @Test("Validate d5p2 from example")
    func p2() {
        let day = try! Day5(data: Day5Tests.data)
        #expect(day.part2() == "14")
    }
}
