//
//  day3.tests.swift
//  AOC25
//
//  Created by Snow Kit on 03/12/2025.
//
import Foundation
import Testing
import AOC25

@Suite("Day 3") struct Day3Tests {
    static let example = "987654321111111\n"
    + "811111111111119\n"
    + "234234234234278\n"
    + "818181911112111"
    static let data = Array(example.utf8)
    
    
    @Test("Validate d3p1 from example")
    func p1() {
        let day = try! Day3(data: Day3Tests.data)
        #expect(day.part1() == "357")
    }
    
    @Test("Validate d3p2 from example")
    func p2() {
        let day = try! Day3(data: Day3Tests.data)
        #expect(day.part2() == "3121910778619")
    }
    
    @Test("Validate Day3 max")
    func test_maxForLine() {
        #expect(Day3.getMaxForLine(line: [1,2,3,4], 2) == 34)
        #expect(Day3.getMaxForLine(line: [1,8,1,9,1], 3) == 891)
    }
}
