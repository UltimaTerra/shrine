import Foundation

/// PRIMARY STATS: What is actually used in day to day gameplay.
/// [STR, ATK, DEF, RFX, SPD]
/// [MAG, WIS, FTH, ING, INN]
/// SHADOW STATS: Based on the above 10 using the averages of the two to get the result. Due to math, it is nice if this were even.
/// [STR: POW, END], [ATK: PDMG, MDMG], [DEF: PDEF, MDEF]
/// [MAG: FOC, MEM], [WIS: CRT, SKL], [FTH: LUK, FTE]
/// RESOURCE STATS: Like every other RPG
/// [HP, MP, SP, LP], [LEVEL]
/// Unique stats based on 1, 2, and 3.
/// [EXP, LMT],

// Starting with your original enums, and making them clearer
enum MenuEntry {
    case play
    case settings
    case ticketcode
    case dlc
}

enum MenuExit {
    case confirm
    case exit
}

struct Main {
    var initLoop: MenuEntry
    var exitLoop: MenuExit
    // We can extend state here
    var currentSelection: Int = 0
    var isActive: Bool = true

    // State mutations belong here
    mutating func nextSelection() {
        currentSelection = (currentSelection + 1) % 4  // Number of MenuEntry cases
    }

    mutating func previousSelection() {
        currentSelection = (currentSelection - 1 + 4) % 4
    }

    mutating func handleInput(_ input: String) {
        switch input.lowercased() {
        case "w": previousSelection()
        case "s": nextSelection()
        case "q":
            isActive = false
            exitLoop = .exit
        default: break
        }
    }
}

enum Color {
    case r, g, b, a
}

enum HexGrid {
    case x, y, z
}
//
//
protocol Sortable {
    associatedtype Value
    // Base method returns 0-7 for our octal partitioning
    func sortValue() -> UInt

    // Default implementation for octal properties
    var isOctalEven: Bool { get }
    var octalPartition: UInt { get }
}
//
//
extension Sortable {
    var isOctalEven: Bool {
        // 0,2,4,6 are even in base-8
        let value = sortValue() % 8
        return value % 2 == 0
    }

    var octalPartition: UInt {
        return sortValue() % 8
    }
}

protocol Packable {
    associatedtype Backpack

    func defineStorage()
    func sortStorage()

    var octalSchemaSlot: [UInt] { get set }
    var maxSchemaStorageSlot: [Bool] { get set }
}

/// A description
struct Backpack<I: Packable> {
    typealias Backpack = [UInt]

    func defineStorage() {

    }
    func sortStorage() {

    }

    var octalSchemaSlot: [UInt] = []
    var maxSchemaStorageSlot: [Bool] = []

}

struct SortedHash<V: Sortable> {
    private var partitions: [[(key: UInt, value: V)]] = Array(repeating: [], count: 8)

    // Quick access to even/odd partitions
    var evenPartitions: [[(key: UInt, value: V)]] {
        [partitions[0], partitions[2], partitions[4], partitions[6]]
    }

    var oddPartitions: [[(key: UInt, value: V)]] {
        [partitions[1], partitions[3], partitions[5], partitions[7]]
    }

    // Force zero into odd category if needed
    func queryWithZeroAsOdd(matching closure: (V) -> Bool) -> [V] {
        let zeroPartition = partitions[0].map { $0.value }.filter(closure)
        return oddPartitions.flatMap { partition in
            partition.map { $0.value }.filter(closure)
        } + zeroPartition
    }
}

// Example usage:
struct ItemCategory: Sortable {
    typealias Value = UInt

    let type: UInt  // 0-7
    let name: String

    func sortValue() -> UInt {
        return type
    }

    // Categories could be:
    // 0: Special/None (can be coerced to odd if needed)
    // 1: Weapons
    // 2: Armor
    // 3: Consumables
    // 4: Materials
    // 5: Quest Items
    // 6: Crafting Items
    // 7: Backpack Items (Inventory)
}

// At the bottom of your file:
protocol GameProgram {
    static func run()
}

struct D7: GameProgram {
    static func run() {
        var gameMenu = Main(initLoop: .play, exitLoop: .confirm)
        // ... rest of your main loop code ...
        print("Welcome to Dragon Seven!")

        while gameMenu.isActive {
            print("\u{001B}[2J\u{001B}[H")
            print("Current selection: \(gameMenu.currentSelection)")
            print("[W] Up [S] Down [Q] Quit")

            if let input = readLine() {
                gameMenu.handleInput(input)
            }
        }

        print("Thanks for playing Dragon Seven!")
    }
}

// Call it
D7.run()
