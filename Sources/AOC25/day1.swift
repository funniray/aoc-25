//
//  day1.swift
//  AOC25
//
//  Created by Snow Kit on 02/12/2025.
//
import Foundation

public class Day1: Day {
    let sequence: [Int]
    
    public required init(data: [UInt8]) throws {
        self.sequence = try Day1.parseInput(data: data)
    }
    
    private static func parseInput(data: [UInt8]) throws -> [Int] {
        guard let text = String(bytes: data, encoding: .utf8) else {
            throw PuzzleError.badInput
        }
        
        var parsed: [Int] = []
        
        for var sub in text.split(separator: "\n") {
            let multiplier = sub.hasPrefix("L") ? -1 : 1
            sub.removeFirst()
            guard let value = Int(sub) else {
                throw PuzzleError.numberFormat
            }
            parsed.append(value*multiplier)
        }
        
        return parsed
    }
    
    public func part1() -> String {
        var dial = 50
        var atzero = 0
        
        for num in self.sequence {
            dial = (dial + num) %% 100
                        
            if dial == 0 {
                atzero+=1
            }
        }
        
        return "\(atzero)"
    }
    
    public func part2() -> String {
        var pos = 50
        var count = 0
        
        for num in self.sequence {
            let direction: Int = num > 0 ? 1 : -1
            let num_turn: Int = abs(num)
            
            var dist_to_zero: Int = direction == -1 ? pos : 100 - pos
            if dist_to_zero == 0 {
                dist_to_zero = 100
            }
            
            var timesTurned = 0
            
            if dist_to_zero <= num_turn {
                timesTurned = ((num_turn - dist_to_zero) / 100) + 1
                count += timesTurned
            }
            
//            print("position \(pos) \(direction == -1 ? "L" : "R")\(num_turn). Rotated \(timesTurned) times")
            
            pos = (pos + num) %% 100
            
//            let dir = num > 0 ? 1 : -1
//            for _ in 1...abs(num) {
//                pos+=dir
//                pos%=100
//                if pos == 0 {
//                    count += 1
//                }
//            }
        }
        
        return "\(count)"
    }
}


// Source - https://stackoverflow.com/a
// Posted by cdeerinck
// Retrieved 2025-12-02, License - CC BY-SA 4.0

infix operator %%

extension Int {
    static func %% (_ left: Int, _ right: Int) -> Int {
        if left >= 0 { return left % right }
        if left >= -right { return (left+right) }
        return ((left % right)+right)%right
    }
}
