//
//  day3.swift
//  AOC25
//
//  Created by Snow Kit on 03/12/2025.
//

public class Day3: Day {
    let sequence: [ArraySlice<Int>]
    
    public required init(data: [UInt8]) throws {
        self.sequence = try Day3.parseInput(data: data)
    }
    
    private static func parseInput(data: [UInt8]) throws -> [ArraySlice<Int>] {
        var parsed: [Int] = []
        parsed.reserveCapacity(data.count)
        
        let nl: UInt8 = 0x0a
        let zero: UInt8 = 0x30
        let nine: UInt8 = 0x39
        
        var width = 0
        var workingWidth = 0
        
        for char in data {
            if char >= zero && char <= nine {
                parsed.append(Int(char-zero))
                workingWidth += 1
            } else if char == nl {
                if workingWidth == 0 {continue}
                width = workingWidth
                workingWidth = 0
            } else {
                print("Unknown char \(char)")
            }
        }
        
        var holder: [ArraySlice<Int>] = []
        holder.reserveCapacity(parsed.count/width)
        
        for i in 0..<parsed.count/width {
            holder.append(parsed[width*i..<width*(i+1)])
        }
        
        return holder
    }
    
    @inline(__always)
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
    
    @inline(__always)
    public static func getMaxForLine(line: ArraySlice<Int>, _ len: Int) -> Int {
        return Day3.getLargestSubline(line: line[line.startIndex..<line.endIndex], cur: 0, remaining: len-1)
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
