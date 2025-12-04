//
//  day3.swift
//  AOC25
//
//  Created by Snow Kit on 03/12/2025.
//
import Foundation

public class Day3: Day {
    let sequence: [[Int]]
    
    public required init(data: [UInt8]) throws {
        self.sequence = try Day3.parseInput(data: data)
    }
    
    private static func parseInput(data: [UInt8]) throws -> [[Int]] {
        guard let text = String(bytes: data, encoding: .utf8) else {
            throw PuzzleError.badInput
        }
        
        var parsed: [[Int]] = []
        
        for line in text.split(separator: "\n") {
            parsed.append(line.trimmingCharacters(in: .whitespacesAndNewlines).compactMap({Int(String($0))}))
        }
        
        return parsed
    }
    
    public static func getLargestSubline(line: ArraySlice<Int>, cur: Int, remaining: Int) -> Int {
        var largestNum = 0
        var index = 0
        
        for i in line.startIndex..<line.endIndex-remaining {
            let num = line[i]
            if num > largestNum {
                largestNum = num
                index = i
            }
        }
        
        if remaining == 0 {
            return (cur*10)+largestNum
        } else {
            return Day3.getLargestSubline(line: line[index+1..<line.endIndex], cur: (cur*10)+largestNum, remaining: remaining-1)
        }
    }
    
    public static func getMaxForLine(line: [Int], _ len: Int) -> Int {
        return Day3.getLargestSubline(line: line[0..<line.count], cur: 0, remaining: len-1)
    }
    
    public func part1() -> String {
        var accumulator = 0
        
        for line in self.sequence {
            accumulator += Day3.getMaxForLine(line: line, 2)
        }
        
        return "\(accumulator)"
    }
    
    public func part2() -> String {
        var accumulator = 0
        
        for line in self.sequence {
            accumulator+=Day3.getMaxForLine(line: line, 12)
        }
        
        return "\(accumulator)"
    }
    
}
