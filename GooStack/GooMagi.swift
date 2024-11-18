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
enum Axis
{
    case x
    case y
    case z
    case w
}

struct Point
{
    let p0: [Axis]
}

enum DrawCode
{
    case colorCode(UInt)
    case alphaCode(UInt)
}


