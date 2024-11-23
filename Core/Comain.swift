import Foundation
import FoundationXML

class NinjaTool {

    var buildSettings: Set<String>
    var buildFormat: [String]
    var fuseSource: [String: Int]
    var initiateBuild: [NinjaTool]

    init(
        buildSettings: Set<String>,
        buildFormat: [String],
        fuseSource: [String: Int],
        initiateBuild: [NinjaTool]
    ) {
        self.buildFormat = buildFormat
        self.fuseSource = fuseSource
        self.buildSettings = buildSettings
        self.initiateBuild = initiateBuild
    }

}

protocol BuildBuffer {

    func getsetBuild()
    func getsetCache()

}

protocol Drawable {

    func drawWindow()
    func drawToolAPI()

}

protocol DrawScene {

}

class NinjaBuffer {

}
