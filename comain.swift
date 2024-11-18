import Foundation


enum CommandError: Error {
    case batchValidationFailed(reason: String)
    case executionFailed(command: String, reason: String)
    case invalidState(expected: String, actual: String)
    case dataloadError(description: String)
    case queueOverflow(maxSize: Int)
}


protocol Versionable {
    associatedtype VersionID: Hashable
    var version: VersionID { get }
    func branch() -> Self
    func merge(from other: Self) throws
}



protocol CommandDriver {
    associatedtype CommandType: Versionable
    associatedtype StateType: Hashable
    
    var activeCommands: [CommandType.VersionID: CommandType] { get }
    var branchHistory: DirectedGraph<CommandType.VersionID> { get }
    
    func execute(_ command: CommandType) throws
    func revert(to version: CommandType.VersionID) throws
    func branch(from version: CommandType.VersionID) throws -> CommandType.VersionID
}

struct DirectedGraph<NodeID: Hashable> {
    private var adjacencyList: [NodeID: Set<NodeID>] = [:]
    
    mutating func addNode(_ node: NodeID) {
        if adjacencyList[node] == nil {
            adjacencyList[node] = []
        }
    }
    
    mutating func addEdge(from source: NodeID, to destination: NodeID) {
        addNode(source)
        addNode(destination)
        adjacencyList[source]?.insert(destination)
    }
    
    func getChildren(of node: NodeID) -> Set<NodeID> {
        return adjacencyList[node] ?? []
    }
    
    func findPath(from source: NodeID, to destination: NodeID) -> [NodeID]? {
        var visited: Set<NodeID> = []
        var path: [NodeID] = []
        
        func dfs(_ current: NodeID) -> Bool {
            visited.insert(current)
            path.append(current)
            
            if current == destination {
                return true
            }
            
            if let neighbors = adjacencyList[current] {
                for next in neighbors {
                    if !visited.contains(next) {
                        if dfs(next) {
                            return true
                        }
                    }
                }
            }
            
            path.removeLast()
            return false
        }
        
        return dfs(source) ? path : nil
    }
}


class Command<State: Hashable, Record: Hashable> {
    var commandUUID: Array<State>
    var commandQueue: Set<Record>
    var commandDataload: Command<Data, Load>
    private var batchOperations: [BatchOperation] = []
    

    struct Data: Hashable {
        let dataPackage: Array<Int>
        let dataID: Dictionary<UInt64, String>
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(dataPackage)
            hasher.combine(dataID)
        }
        
        static func == (lhs: Data, rhs: Data) -> Bool {
            return lhs.dataPackage == rhs.dataPackage &&
                   lhs.dataID == rhs.dataID
        }
    }
    
    enum Load: Hashable {
        case createcommand
        case redocommand
        case updatecommand
        case deletecommand
        case errorcommand
    }
    

    struct BatchOperation {
        let operations: [Load]
        let target: Data
        let validation: () -> Result<Void, CommandError>
        
        func execute() -> Result<Void, CommandError> {
            // First validate the batch
            switch validation() {
            case .success:
                // Execute all operations in sequence
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    

    func createBatch() -> BatchBuilder {
        return BatchBuilder(command: self)
    }
    
    class BatchBuilder {
        private weak var command: Command?
        private var operations: [Load] = []
        private var targetData: Data?
        
        fileprivate init(command: Command) {
            self.command = command
        }
        
        func add(operation: Load) -> BatchBuilder {
            operations.append(operation)
            return self
        }
        
        func setTarget(data: Data) -> BatchBuilder {
            targetData = data
            return self
        }
        
        func validate(_ validation: @escaping () -> Result<Void, CommandError>) -> Result<BatchOperation, CommandError> {
            guard let data = targetData else {
                return .failure(.batchValidationFailed(reason: "No target data specified"))
            }
            
            let batchOp = BatchOperation(
                operations: operations,
                target: data,
                validation: validation
            )
            
            command?.batchOperations.append(batchOp)
            return .success(batchOp)
        }
    }
    
    // MARK: - Error Recovery
    struct RecoveryPoint {
        let commandUUID: Array<State>
        let commandQueue: Set<Record>
        
        func restore(to command: Command) throws {
            command.commandUUID = commandUUID
            command.commandQueue = commandQueue
        }
    }
    
    func createRecoveryPoint() -> RecoveryPoint {
        return RecoveryPoint(
            commandUUID: commandUUID,
            commandQueue: commandQueue
        )
    }
    

    init(commandUUID: Array<State>, commandQueue: Set<Record>, commandDataload: Command<Data, Load>) {
        self.commandUUID = commandUUID
        self.commandQueue = commandQueue
        self.commandDataload = commandDataload
    }
}


extension Command: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(commandUUID)
        hasher.combine(commandQueue)
        hasher.combine(commandDataload)
    }
    
    static func == (lhs: Command<State, Record>, rhs: Command<State, Record>) -> Bool {
        return lhs.commandUUID == rhs.commandUUID &&
               lhs.commandQueue == rhs.commandQueue &&
               lhs.commandDataload == rhs.commandDataload
    }
}


public protocol Gatekeeper {
    associatedtype Process: Hashable
    var getDriverProcessID: Process { get }
    var getsetDriverProcessID: Process { get set }
    var getProcessSchedule: (Process, Int) { get }
    var getsetProcessSchedule: (Process, Int) { get set }
    
    func createProcess() throws
    func insertProcess() throws
    func deleteProcess() throws
}
