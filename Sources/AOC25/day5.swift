//
//  day5.swift
//  AOC25
//
//  Created by Snow Kit on 05/12/2025.
//

public class Day5: Day {
    let fresh: [PuzzleRange]
    let ids: [Int]
    
    public required init(data: [UInt8]) throws {
        let parsed = try Day5.parseInput(data: data)
        self.fresh = parsed.fresh
        self.ids = parsed.ids
    }
    
    private static func parseInput(data: [UInt8]) throws -> (fresh: [PuzzleRange], ids: [Int]) {
        guard let text = String(validating: data, as: UTF8.self) else {
            throw PuzzleError.badInput
        }
        
        let spl = text.split(separator: "\n\n")
        let freshStr = spl[0]
        let idStr = spl[1]
        
        var fresh: [PuzzleRange] = []
        var ids: [Int] = []
        
        for line in freshStr.split(separator: "\n") {
            let nums = line.split(separator: "-")
            
            if nums.count < 2 {
                throw PuzzleError.badInput
            }
            
            guard let min = Int(nums[0]) else {
                throw PuzzleError.numberFormat
            }
            
            guard let max = Int(nums[1]) else {
                throw PuzzleError.numberFormat
            }
            
            assert(max >= min, "Max should be greater than min")
            
            fresh.append(PuzzleRange(min:min, max: max))
        }
        
        for line in idStr.split(separator: "\n") {
            guard let num = Int(line) else {
                throw PuzzleError.numberFormat
            }
            ids.append(num)
        }
        
        return (fresh, ids)
    }
    
    @inline(__always)
    private func isFresh(num: Int) -> Bool {
        for range in self.fresh {
            if Day2.inRange(range, num: num) {
                return true
            }
        }
        return false
    }
    
    private static func mergeRanges(ranges: [PuzzleRange]) -> [PuzzleRange] {
        var condensedRange: [PuzzleRange] = []
        condensedRange.reserveCapacity(ranges.count)
        var merged = 0
        
        for range in ranges {
            var found = false
            for existing in condensedRange.enumerated() {
                let minIn = Day2.inRange(existing.element, num: range.min)
                let maxIn = Day2.inRange(existing.element, num: range.max)
                
                if minIn || maxIn {
                    found = true
                    merged += 1
                    
                    if range.min < existing.element.min {
                        var elm = existing.element
                        elm.min = range.min
                        condensedRange[existing.offset] = elm
                    }
                    if range.max > existing.element.max {
                        var elm = existing.element
                        elm.max = range.max
                        condensedRange[existing.offset] = elm
                    }
                }
            }
            
            if !found {
                condensedRange.append(range)
            }
        }
        
        if merged > 0 {
            return mergeRanges(ranges: condensedRange)
        } else {
            return condensedRange
        }
    }
    
    public func part1() -> String {
        "\(self.ids.filter(isFresh).count)"
    }
    
    public func part2() -> String {
        var merged = Day5.mergeRanges(ranges: self.fresh)
        var lastSize = 0
        
        while merged.count != lastSize {
            lastSize = merged.count
            merged = Day5.mergeRanges(ranges: merged.reversed())
        }
        
        return "\(merged.map{($0.max - $0.min)+1}.reduce(0, {$0+$1}))"
    }
    
    
}
