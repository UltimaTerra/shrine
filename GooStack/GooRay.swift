import Foundation

enum RayDriver
{
    case audio
    case video
    case graphic
    case visual
    case gmdb
}

enum RayMessage
{
    case shaderprocess
    case stateprocess
    case gamerunprocess
    case appengineprocess
}

enum GetOperation
{
    case getObject
    case getDestructor
}

enum SetOperation
{
    case setObject
    case setConstructor
}

class RayBase
{
    
}
