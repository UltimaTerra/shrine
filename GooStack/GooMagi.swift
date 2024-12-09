import Foundation

/*
*
*
*
*
*
*
*
*/
enum Axis {
    case x
    case y
    case z
    case w/// this is kind of optional, it is only for creating a layer value
}

struct PointDifferential {
    let p0: [Axis]
    let p1: [Axis]
}

enum MagiToken {
    case leftparenthesis  // (
    case rightparenthesis  // )
    case leftbracket  // {
    case rightbracket  // }
    case leftbrace  // [
    case rightbrace  // ]
    case dot  // .
    case force  // !
    case keyliteral  // if, else, truthy, false etc
    case comment  //  // or /**/ for multi-line/nested
    case ppmacro  // $, #
    case axxvar  // @
    case pointer  // ^& / &^
    case borrow  // &@
    case operatortoken  // / * + -   == >= <= !=, ^ & ~ |, >  < ,
}

struct MagiTokenKind {

}

struct MagiKeyKind {

}

enum DrawCode {
    case colorCode(UInt)
    case alphaCode(UInt)
}

protocol Drawable {
    associatedtype Point
    var pointBBox: PointDifferential { get set }
    func drawPoint<P>(pointset: [P], pointDiff: PointDifferential) -> Point
    func drawBox<U, P>(upointx: [U], upointy: [P], pointDiff: PointDifferential) -> Point

}
/// Drawable
struct Window {
    let colorBox: [DrawCode]
    let pointDiff: [PointDifferential]
}

protocol Tokenizable {

}
protocol Interpretation {

}

let x: Int? = 9

if let y = x {
    print("Y is: \(y)")
} else {
    print("Value is nil.")
}

// Basic enum
enum Direction {
    case north, south, east, west
}

let possibleDirection: Direction? = .north
if let direction = possibleDirection {
    print("We're heading \(direction)")
}

// Enum with associated values
enum Result {
    case success(message: String)
    case failure(error: String)
}

// Enum with associated values
enum Rosult {
    case success(message: String)
    case failure(error: String)
}

let operation: Rosult? = .success(message: "Task completed")
if let result = operation {
    switch result {
    case .success(let message):
        print("Success: \(message)")
    case .failure(let error):
        print("Failed: \(error)")
    }
}

// Generic enum
enum Box<T> {
    case empty
    case filled(content: T)
}

let stringBox: Box<String>? = .filled(content: "Hello")
if let box = stringBox {
    switch box {
    case .empty:
        print("Box is empty")
    case .filled(let content):
        print("Box contains: \(content)")
    }
}
