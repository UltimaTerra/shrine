protocol Modularizer {
    associatedtype GooPlug
    associatedtype ModuleMetaID

    func getplugsetid(getPlugin: () -> GooPlug) -> ModuleMetaID
}

struct ModuleSchema {
    let modName: String
    let modType: ModuleType
    let modIns: ModuleInstructions

    enum ModuleType {}
    enum ModuleInstructions {}

}
public struct PluginModule: Modularizer {
    typealias GooPlug = [String]
    typealias ModuleMetaID = [UInt128]

    // our direct handle for our module schema
    let modBlueprint: ModuleSchema

    /// todo
    func getplugsetid(getPlugin: () -> GooPlug) -> ModuleMetaID {
        return [0, 0, 0]
    }

}

protocol Modularizable {
    func getModule()
    func setModule()
    func readModule()
    func writeModule()
    func updateModule()
    func cacheModule()
}

/// attach the Modularizable Protocol Here
final class GooPlug {
    var modulePlugin: PluginModule

    init(modulePlugin: PluginModule) {
        self.modulePlugin = modulePlugin
    }

}
