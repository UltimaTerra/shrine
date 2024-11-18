import Foundation
import FoundationXML

// MARK: - Core Data Types (Unchanged)
enum Color {
    case red(UInt8), blue(UInt8), green(UInt8), alpha(UInt8)
}

enum ColorCode {
    case red(String), blue(String), green(String), alpha(String)
}

enum DrawCode {
    case pointx(UInt), pointy(UInt)
}

enum CommandLine<I, O> {
    case inputs(I), outputs(O)
}

// MARK: - Error Management
enum Torii {
    // System-level severity indicators
    enum Severity {
        case yellow  // "that ain't so bad" - warning
        case orange  // "that can be bad" - error, recoverable
        case red     // "that is bad" - error, system stability at risk
        case black   // "that is very bad" - critical system failure
        
        var isRecoverable: Bool {
            switch self {
            case .yellow, .orange: return true
            case .red, .black: return false
            }
        }
    }
    
    // Structured error type
    struct SystemError: Error {
        let severity: Severity
        let context: String
        let recovery: (() async -> Void)?
        
        static func warning(_ message: String) -> SystemError {
            SystemError(severity: .yellow, context: message, recovery: nil)
        }
        
        static func critical(_ message: String) -> SystemError {
            SystemError(severity: .black, context: message, recovery: nil)
        }
    }
}

// MARK: - Updated Async Protocols
protocol Rasterizable {
    func drawWindow(width: UInt, height: UInt) async throws
    func loadImage(from path: String) async throws -> Bool
    func render() async throws
}

protocol QueueSchema {
    associatedtype T: Sendable
    var count: Int { get async }
    func push(_ item: T) async throws
    func pop() async throws -> T?
}

protocol TapePlayer {
    associatedtype T: Sendable
    func start() async throws
    func stop() async throws
    func isPlaying() async -> Bool
}

// MARK: - System Level (Multi-core) Components
actor SystemTape<T: Sendable> {
    private var data: [T]
    private let processingQueue: DispatchQueue
    
    init() {
        self.data = []
        self.processingQueue = DispatchQueue(label: "com.torii.system.tape",
                                           qos: .userInteractive,
                                           attributes: .concurrent)
    }
    
    func process(_ operation: @escaping (T) async throws -> T) async throws {
        try await withThrowingTaskGroup(of: T.self) { group in
            for item in data {
                group.addTask {
                    try await operation(item)
                }
            }
            // Collect results
            data = try await group.reduce(into: []) { $0.append($1) }
        }
    }
}

// MARK: - Application Level (Single-core) Components
final class ApplicationTape<T: Sendable> {
    private var data: [T]
    
    init() {
        self.data = []
    }
    
    func process(_ operation: (T) throws -> T) throws {
        data = try data.map(operation)
    }
}

// MARK: - Kernel Facade
actor ToriiKernelTheater {
    // Subsystems
    private let systemTape: SystemTape<Any>
    private let applicationTape: ApplicationTape<Any>
    private var engineState: EngineState
    
    enum EngineState {
        case initializing
        case running(tasks: Int)
        case paused
        case shuttingDown
        case error(Torii.SystemError)
    }
    
    init() {
        self.systemTape = SystemTape()
        self.applicationTape = ApplicationTape()
        self.engineState = .initializing
    }
    
    // Public API
    func start() async throws {
        engineState = .running(tasks: 0)
        try await startSubsystems()
    }
    
    private func startSubsystems() async throws {
        // Start with error handling
        do {
            try await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    // System-level operations
                }
                
                group.addTask {
                    // Application-level operations
                }
            }
        } catch let error as Torii.SystemError {
            engineState = .error(error)
            if error.severity.isRecoverable {
                await error.recovery?()
            } else {
                throw error
            }
        }
    }
}

// MARK: - Engine Runner (Main Interface)
final class ToriiEngineRunner {
    private let kernel: ToriiKernelRunner
    private var isRunning = false
    
    init() {
        self.kernel = ToriiKernelFacade()
    }
    
    func run() async throws {
        guard !isRunning else {
            throw Torii.SystemError(
                severity: .orange,
                context: "Engine already running",
                recovery: { /* Recovery logic */ }
            )
        }
        
        do {
            try await kernel.start()
            isRunning = true
        } catch let error as Torii.SystemError where error.severity == .black {
            // Critical failure handling
            print("Critical system failure: \(error.context)")
            throw error
        }
    }
}

// MARK: - Example Usage
extension ToriiEngineRunner {
    static func example() async throws {
        let engine = ToriiEngineRunner()
        
        do {
            try await engine.run()
        } catch let error as Torii.SystemError {
            switch error.severity {
            case .yellow:
                print("Warning: \(error.context)")
            case .orange:
                print("Error (recoverable): \(error.context)")
                await error.recovery?()
            case .red:
                print("Severe error: \(error.context)")
                // Attempt graceful shutdown
            case .black:
                print("Critical failure: \(error.context)")
                // Immediate shutdown
            }
        }
    }
}
