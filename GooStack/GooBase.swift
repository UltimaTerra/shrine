import Foundation
import FoundationXML

///
///
///

enum GooError: Error {
    case yellow
    case orange
    case red
    case black
    case blue
}
///
///
///
protocol Zonable {
    associatedtype Zone
    associatedtype ZoneID

    typealias Slice = Zone
    typealias UUID = ZoneID

    func generateZone()
    func growZone()
    func anchorZone2Arena()
    func deleteZone4Arena()
}
///
///
///
///
protocol Slicable {
    associatedtype Item
    typealias Slice = Item

    func sliceLow()
    func sliceHigh()
}
///
///
///
///
struct Slice<S> {
    var sliceData: [S]
}
///
///
///
///
struct ArenaStore<A, S> where A: Hashable {

}
class Arena<Element, Buffer> where Element: Slicable, Buffer: Zonable {

}
class GooDriver {

}
class GooKernel {

}

final class GooQuartz {
    /// Register the Driver + Kernel
    /// With the Global Arena, index Slice + Zones
    /// Wrap constructors/deconstructors with reflection -> edit -> prebuild -> logloop

}

class InibinParser {
    var file: [String: String]
    /// --> .ini -> file format for container
    /// --> format for data
    /// --> export .ini -> terminal io
    /// --> .ini -> format headers/sections

    init(file: [String: String]) {
        self.file = file
    }

}

/// GooBase: public functions
///
///

/// generate core base function, with related teardown and rebuild functions
public func initBase() {

    func tearBase() {

    }
    func rebuildBase() {

    }

}

/// clean up base and the kernel writes to the engine container.
public func exitcleanBase() {

}
