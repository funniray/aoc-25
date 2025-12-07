// The Swift Programming Language
// https://docs.swift.org/swift-book
import AOC25

var number = CommandLine.arguments.count > 1 ? Int(CommandLine.arguments[1]) : 7


do {
    let day = try getDay(number ?? 1)
    print("Part 1 \(day.part1())\nPart 2 \(day.part2())")
} catch let error as PuzzleError {
    print(error.description)
}

private func getDay(_ number: Int) throws -> Day {
    switch (number) {
    case 1: return try Day1(data: PackageResources.day_1_txt)
    case 2: return try Day2(data: PackageResources.day_2_txt)
    case 3: return try Day3(data: PackageResources.day_3_txt)
    case 4: return try Day4(data: PackageResources.day_4_txt)
    case 5: return try Day5(data: PackageResources.day_5_txt)
    case 6: return try Day6(data: PackageResources.day_6_txt)
    case 7: return try Day7(data: PackageResources.day_7_txt)
    default: throw PuzzleError.dayNotFound
    }
}
