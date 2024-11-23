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
    case w
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
    case assvar  // @
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

protocol Parsable {

}

protocol Lexemescopable {

}

protocol GardenWalkable {

}
