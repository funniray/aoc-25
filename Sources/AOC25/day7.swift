//
//  day7.swift
//  AOC25
//
//  Created by Snow Kit on 07/12/2025.
//

public class Day7: Day {
    let sequence: [Bool]
    let width: Int
    
    public required init(data: [UInt8]) throws {
        let parsed = try Day7.parseInput(data: data)
        self.sequence = parsed.seq
        self.width = parsed.width
    }
    
    private static func parseInput(data: [UInt8]) throws -> (seq: [Bool], width: Int) {
        let dot = Character(".").asciiValue!
        let nl = Character("\n").asciiValue!
        
        var row = 0
        var width = 0
        var seq: [Bool] = []
        seq.reserveCapacity(data.count/2)
        
        for char in data {
            if char == nl {
                row += 1
                continue
            }
            if row % 2 != 0 {
                continue // every other line is useless
            }
            if row == 0 {
                width += 1
            }
            
            seq.append(char != dot)
        }
        
        return (seq, width)
    }
    
    public func solve() -> (split: Int, options: Int) {
        var state: [Int] = Array(sequence[0..<width].map({$0 ? 1 : 0}))
        let rows = sequence.count/width
        var splits = 0
        
        for r in 1..<rows { // intentionally skip first row
            var newState: [Int] = Array(repeating: 0, count: state.count)
            
            for c in 0..<width {
                let current = state[c]
                let splitter = sequence[(r*width)+c]
                
                if current == 0 {
                    continue
                }
                
                if splitter {
                    splits += 1
                    newState[c-1] += current
                    newState[c+1] += current
                } else {
                    newState[c] += current
                }
            }
            
            state = newState
        }
        
        return (splits, state.reduce(0, {$0+$1}))
    }
    
    public func part1() -> String {
        return "\(solve().split)"
    }
    
    public func part2() -> String {
        return "\(solve().options)"
    }
    
    
}
