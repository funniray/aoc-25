//
//  day4.swift
//  AOC25
//
//  Created by Snow Kit on 04/12/2025.
//

public class Day4: Day {
    let sequence: [Bool]
    let sizeX: Int
    let sizeY: Int
    
    public required init(data: [UInt8]) throws {
        let parsed = try Day4.parseInput(data: data)
        self.sequence = parsed.sequence
        self.sizeX = parsed.sizeX
        self.sizeY = parsed.sizeY
    }
    
    private static func parseInput(data: [UInt8]) throws -> (sequence: [Bool], sizeX: Int, sizeY: Int) {
        let at: UInt8 = 0x40
        let dot: UInt8 = 0x2e
        let nl: UInt8 = 0x0a
        
        var width = 0
        var workingWidth = 0
        
        var sequence: [Bool] = []
        sequence.reserveCapacity(data.count)
        
        for char in data {
            switch char {
            case at:
                sequence.append(true)
                workingWidth += 1
            case dot:
                sequence.append(false)
                workingWidth += 1
            case nl:
                if workingWidth == 0 {continue}
                width = workingWidth
                workingWidth = 0
            default:
                print("Unknown char \(char)")
            }
        }
        
        return (sequence, width, sequence.count/width)
    }
    
    @inline(__always)
    private static func surrounding(position: TilePosition, sequence: [Bool]) -> Int {
        var surround = 0
        var checkPos: TilePosition? = nil
        
        checkPos = position.tileWithOffset(x: -1, y: -1)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: -1, y: 0)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: -1, y: 1)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: 0, y: -1)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: 0, y: 1)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: 1, y: -1)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: 1, y: 0)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        checkPos = position.tileWithOffset(x: 1, y: 1)
        if checkPos != nil && sequence[checkPos!] {
            surround += 1
        }
        
        return surround
    }
    
    public func part1() -> String {
        var accessible = 0
        
        for y in 0..<self.sizeY {
            for x in 0..<self.sizeX {
                let position = TilePosition(x:x, y:y, sizex: self.sizeX, sizey: self.sizeY)
                let current = self.sequence[position]
                if !current {continue}
                let num = Day4.surrounding(position: position, sequence: self.sequence)
                if num < 4 {
                    accessible += 1
                }
            }
        }
        
        return "\(accessible)"
    }
    
    public func part2() -> String {
        var accessible = 0
        var modified = -1
        var workingState = self.sequence
        
        while modified != 0 {
            modified = 0
            for y in 0..<self.sizeY {
                for x in 0..<self.sizeX {
                    let position = TilePosition(x:x, y:y, sizex: self.sizeX, sizey: self.sizeY)
                    let current = workingState[position]
                    if !current {continue}
                    let num = Day4.surrounding(position: position, sequence: workingState)
                    if num < 4 {
                        modified += 1
                        workingState[position] = false
                    }
                }
            }
            accessible += modified
        }
        
        return "\(accessible)"
    }
    
    
}

// Stolen from https://github.com/funniray/SwiftSweeper/blob/main/SwiftSweeper/SweeperState.swift
// It's my own code.
struct TilePosition {
    let x: Int
    let y: Int
    let sizex: Int
    let sizey: Int
    
    static func fromIndex(i: Int, sizex: Int, sizey: Int) -> TilePosition {
        let x = i%sizex
        let y = i/sizex
        return .init(x:x, y:y, sizex: sizex, sizey: sizey)
    }
    
    func tileWithOffset(x: Int, y: Int) -> TilePosition? {
        if (self.x+x < 0 || self.y+y < 0 || self.x+x >= sizex || self.y+y >= sizex) {
            return nil
        }
        return TilePosition(x: self.x+x, y: self.y+y, sizex: self.sizex, sizey: self.sizey)
    }
}

// Helper to allow accessing TileState Arrays using their position
extension Array {
    internal static func indexAt(_ position: TilePosition) -> Int {
        return position.x + position.y*position.sizex
    }
    
    subscript (_ position: TilePosition) -> Element {
        get {
            return self[Array.indexAt(position)]
        }
        mutating set {
            self[Array.indexAt(position)] = newValue
        }
        
    }
}

