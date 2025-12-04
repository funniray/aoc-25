//
//  utils.swift
//  AOC25
//
//  Created by Snow Kit on 02/12/2025.
//

public protocol Day {
    init(data: [UInt8]) throws
    func part1() -> String
    func part2() -> String
}

public enum PuzzleError: Error {
    case badInput
    case numberFormat
    case dayNotFound
}

extension PuzzleError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .badInput: "Input was bad"
        case .numberFormat: "Failed to parse number"
        case .dayNotFound: "Day not found"
        }
    }
}
