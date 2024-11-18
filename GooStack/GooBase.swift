import Foundation
import FoundationXML
///
protocol Initializer
{
    associatedtype Data
    associatedtype Buffer

    func createAnyInitializer(b1: Buffer, b2: Buffer) -> (Data)
    func destroyAnyInitializer(d0: Data) -> Buffer?
}
///
protocol ErrorRegister
{
    func returnErrorColor(errColor: EngineErrorColors)
    func returnErrorCode(errID: EngineErrorCodes)
}
///
enum EngineErrorColors
{
    case yellow
    case orange
    case red
    case black
}
///
enum EngineErrorCodes
{
    indirect case one
    indirect case two
    indirect case three
}
///
enum EngineDriverType
{
    indirect case ogl46 /// least coolest driver name
    indirect case vk13 /// third coolest driver name
    indirect case directx /// coolest driver name
    indirect case metal /// second coolest driver name
    indirect case webdawn /// negative first coolest driver name.
}
///
enum EngineDriverBuffer<D, B>
{
    case dataPacket(D)
    case dataBuffer(B)
    indirect case dataStream(D?, B)
}
///
enum EngineAudio<A>
{
    case audBuffer1 /// and like, maybe 7 more
}
///
enum EngineVideo<V>
{
    case vidBuffer1 /// and like maybe 7 more
}
