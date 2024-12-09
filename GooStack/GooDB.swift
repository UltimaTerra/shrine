import CoreFoundation
import Foundation
import FoundationXML

class GooManager {
    var anyFiler: FileManager
    var xmlParsers: XMLParser

    init(anyFiler: FileManager, xmlParsers: XMLParser) {
        self.anyFiler = anyFiler
        self.xmlParsers = xmlParsers
    }
}

// Create some sample XML data to parse
let xmlString = "<?xml version='1.0' encoding='UTF-8'?><root></root>"
let xmlData = xmlString.data(using: .utf8)!

// Create an XMLParser instance with the data
let parser = XMLParser(data: xmlData)

// Now create the GooManager with actual instances
let manager = GooManager(anyFiler: FileManager.default, xmlParsers: parser)
print(xmlString)
