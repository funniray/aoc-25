//
//  day2.swift
//  AOC25
//
//  Created by Snow Kit on 02/12/2025.
//
import Foundation

public class Day2: Day {
    let sequence: [PuzzleRange]
    
    public required init(data: [UInt8]) throws {
        self.sequence = try Day2.parseInput(data: data)
    }
    
    private static func parseInput(data: [UInt8]) throws -> [PuzzleRange] {
        guard let text = String(bytes: data, encoding: .utf8) else {
            throw PuzzleError.badInput
        }
        
        var parsed: [PuzzleRange] = []
        
        for sub in text.split(separator: ",") {
            let nums = sub.split(separator: "-")
            
            if nums.count < 2 {
                throw PuzzleError.badInput
            }
            
            guard let min = Int(nums[0].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                throw PuzzleError.numberFormat
            }
            
            guard let max = Int(nums[1].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                throw PuzzleError.numberFormat
            }
            
            parsed.append(PuzzleRange(min:min, max: max))
        }
        
        return parsed
    }
    
    public static func splitRange(_ range: PuzzleRange) -> [PuzzleRange] {
        var workingRange = range
        
        var ranges: [PuzzleRange] = []
        while workingRange.min.strlen != workingRange.max.strlen {
            let size = workingRange.min.strlen
            let split = 10^^size
            let leftRange = PuzzleRange(workingRange.min, split-1)
            let rightRange = PuzzleRange(split, workingRange.max)
            
            ranges.append(leftRange)
            workingRange = rightRange
        }
        
        ranges.append(workingRange)
        return ranges
    }
    
    @inline(__always)
    public static func inRange(_ range: PuzzleRange, num: Int) -> Bool {
        return num >= range.min && num <= range.max
    }
    
    public static func generateInvalidForRange(_ range: PuzzleRange, nums: Int, maxRepeat: Int? = nil) -> [Int] {
        if range.min.strlen % nums != 0 {
            return []
        }
        
        let len = range.min.strlen
        let repeats = max(2,len/nums)
        
        if maxRepeat != nil && repeats != maxRepeat {
            return []
        }
        
        let min = range.min.split(len-nums).left
        let max = range.max.split(len-nums).left
        
        var accumulator: [Int] = []
        for i in min...max {
            let canidate = i.repeating(repeats)
            if !Day2.inRange(range, num: canidate) {continue}
            accumulator.append(canidate)
        }
        return accumulator
    }
    
    public func part1() -> String {
        var accumulator = 0
        
        for values in self.sequence.flatMap({Day2.splitRange($0)}) {
            let len = max(1,values.min.strlen/2)
            accumulator+=Day2.generateInvalidForRange(values, nums: len, maxRepeat: 2).reduce(0,{$0+$1})
        }
        
        return "\(accumulator)"
    }
    
    public func part2() -> String {
        var accumulator = 0
        
        for values in self.sequence.flatMap({Day2.splitRange($0)}) {
            let len = max(1,values.min.strlen/2)
            var nums: Set<Int> = []
            for i in 1...len {
                for num in Day2.generateInvalidForRange(values, nums: i) {
                    nums.insert(num)
                }
            }
            accumulator+=nums.reduce(0, {$0+$1})
        }
        
        return "\(accumulator)"
    }
}

// Source - https://stackoverflow.com/a/24201042
// Posted by Grimxn, modified by community. See post 'Timeline' for change history
// Retrieved 2025-12-02, License - CC BY-SA 3.0

public typealias PuzzleRange = (min: Int, max: Int)
public typealias IntSplit = (left: Int, right: Int)


infix operator ^^

extension Int {
    @inline(__always)
    static func ^^ (radix: Int, power: Int) -> Int {
        return Int(pow(Double(radix), Double(power)))
    }
    
    @inline(__always)
    public var strlen: Int {
        if self == 0 {return 1}
        return Int(floor(log10(Double(self))+1))
    }
    
    @inline(__always)
    public func split(_ split_size: Int) -> IntSplit {
        let right_size = 10^^split_size
        
        let left = self/right_size
        let right = self%right_size
        return IntSplit(left:left, right:right)
    }
    
    @inline(__always)
    public func repeating(_ count: Int) -> Int {
        var working = self
        let len = 10^^self.strlen
        for _ in 1..<count {
            working = (working * len) + self
        }
        return working
    }
}
