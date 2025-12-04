//
//  day2.tests.swift
//  AOC25
//
//  Created by Snow Kit on 02/12/2025.
//
import Foundation
import Testing
import AOC25

@Suite("Day 2") struct Day2Tests {
    static let example = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    static let data = Array(example.utf8)
    
    @Test("Validate d2p1 from example")
    func p1() {
        let day = try! Day2(data: Day2Tests.data)
        #expect(day.part1() == "1227775554")
    }
    
    @Test("Validate d2p2 from example")
    func p2() {
        let day = try! Day2(data: Day2Tests.data)
        #expect(day.part2() == "4174379265")
    }
    
    @Test("Verify log based string length for ints")
    func strlen_test() {
        #expect (999.strlen == 3)
        #expect (1_000.strlen == 4)
        #expect (1_234.strlen == 4)
        #expect (9_999.strlen == 4)
    }
    
    @Test("Verify int split works correctly")
    func intsplit_test() {
        var split: IntSplit
        
        split = 1234.split(2)
        #expect (split.left == 12)
        #expect (split.right == 34)
        
        split = 1234.split(1)
        #expect (split.left == 123)
        #expect (split.right == 4)
    }
    
    @Test("Verify day2 int repeating works")
    func intrepeat_test() {
        #expect (123.repeating(2) == 123123)
    }
    
    @Test("Validate Day2 Split range")
    func test_splitrange() {
        let range = PuzzleRange(22, 1111)
        let ranges = Day2.splitRange(range)
        #expect (ranges.count == 3)
        #expect (ranges[0] == (22,99))
        #expect (ranges[1] == (100,999))
        #expect (ranges[2] == (1000,1111))
    }
    
    @Test("Validate Day2 in range")
    func test_inRange() {
        #expect(Day2.inRange((20,30), num: 25))
    }
    
    @Test("Validate Day2 generateInvalid")
    func test_generation() {
        #expect(Day2.generateInvalidForRange((11,20), nums: 1).reduce(0, {$0+$1}) == 11)
        #expect(Day2.generateInvalidForRange((11,22), nums: 1).reduce(0, {$0+$1}) == 33)
    }
}
