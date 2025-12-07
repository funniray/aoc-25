//
//  day6.swift
//  AOC25
//
//  Created by Snow Kit on 07/12/2025.
//

public class Day6: Day {
    let sequence: [Int]
    let p2Sequence: [Int]
    let multiplySequence: [Bool]
    let rows: Int
    
    public required init(data: [UInt8]) throws {
        let parsed = try Day6.parseInput(data: data)
        self.sequence = parsed.nums
        self.multiplySequence = parsed.multiply
        self.p2Sequence = parsed.p2Nums
        self.rows = parsed.rows
    }
    
    private static func parseInput(data: [UInt8]) throws -> (nums: [Int], p2Nums: [Int], multiply: [Bool], rows: Int) {
        let nl = Character("\n").asciiValue!
        let space = Character(" ").asciiValue!
        let zero = Character("0").asciiValue!
        let mult = Character("*").asciiValue!
        
        var lines = data.split(separator: nl)
        let multLine = lines.removeLast().split(separator: space, omittingEmptySubsequences: true)
        
        var nums: [Int] = []
        var newNums: [Int] = []
        var multiply: [Bool] = []
        
        multiply.reserveCapacity(multLine.count)
        nums.reserveCapacity(multLine.count*lines.count)
        newNums.reserveCapacity(multLine.count*lines.count)
        
        for i in 0..<lines[0].count {
            var num = 0
            
            for j in 0..<lines.count {
                let idx: Int = lines[j].startIndex + i
                let char = data[idx]
                if char == space {continue}
                let subNum = char - zero
                assert(subNum < 10, "Ensure subNum isn't too large")
                num = (num*10)+Int(subNum)
            }
            
            newNums.append(num)
        }
        
        for line in lines {
            for subline in line.split(separator: space, omittingEmptySubsequences: true) {
                var num = 0
                for char in subline {
                    let subNum = char - zero
                    num = (num*10)+Int(subNum)
                }
                if num != 0 {nums.append(num)}
            }
        }
        
        for char in multLine {
            if char.first! == mult {
                multiply.append(true)
            } else {
                multiply.append(false)
            }
        }
        
        return (nums, newNums, multiply, lines.count)
    }
    
    public func part1() -> String {
        var accumulator = 0
        
        for i in 0..<multiplySequence.count {
            let multiply = multiplySequence[i]
            var localAccumulator = sequence[i]
            for j in 1..<sequence.count/multiplySequence.count {
                let num = sequence[i+(j*multiplySequence.count)]
                if multiply {
                    localAccumulator*=num
                } else {
                    localAccumulator+=num
                }
            }
            accumulator+=localAccumulator
        }
        
        return "\(accumulator)"
    }
    
    public func part2() -> String {
        var accumulator = 0
        var i = 0
        
        var localAccumulator = 0
        for num in p2Sequence {
            if num == 0 {
                i+=1
                accumulator += localAccumulator
                localAccumulator = 0
                continue
            }
            if localAccumulator == 0 {
                localAccumulator = num
                continue
            }
            let multiply = self.multiplySequence[i]
                      
            if multiply {
                localAccumulator*=num
            } else {
                localAccumulator+=num
            }
        }
        accumulator += localAccumulator
        
        assert((self.multiplySequence.count-1) == i, "ensure every number was accounted for")
        return "\(accumulator)"
    }
    
    
}
