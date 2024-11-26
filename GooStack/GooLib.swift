public protocol TreeMutatability {
    associatedtype Tree
    typealias Array<Tree> = Tree
    var firstParent: Tree { get set }
    var secondChildren: (Tree, Tree) { get set }
}

enum GooTree<T: TreeMutatability>: TreeMutatability {
    case leaf(T)
    indirect case node(T, left: GooTree<T>, right: GooTree<T>)

    // First, we need to specify that Tree is T
    typealias Tree = T

    var firstParent: T {
        get {
            switch self {
            case .leaf(let value):
                return value
            case .node(let value, _, _):
                return value
            }
        }
        set {
            switch self {
            case .leaf:
                self = .leaf(newValue)
            case .node(_, let left, let right):
                self = .node(newValue, left: left, right: right)
            }
        }
    }

    var secondChildren: (T, T) {
        get {
            switch self {
            case .leaf(let value):
                return (value, value)  // You might want to handle this case differently
            case .node(_, let left, let right):
                return (left.firstParent, right.firstParent)
            }
        }
        set {
            switch self {
            case .leaf:
                // You might want to handle this case differently
                self = .node(
                    firstParent,
                    left: .leaf(newValue.0),
                    right: .leaf(newValue.1))
            case .node(let value, _, _):
                self = .node(
                    value,
                    left: .leaf(newValue.0),
                    right: .leaf(newValue.1))
            }
        }
    }
}

enum GooTreeError: Error {
    case cannotGetChildrenFromLeaf
    case cannotSetChildrenOnLeaf
}

extension GooTree {
    func map<U>(_ transform: (T) -> U) -> GooTree<U> where U: TreeMutatability {
        switch self {
        case .leaf(let value):
            return .leaf(transform(value))
        case .node(let value, let left, let right):
            return .node(
                transform(value),
                left: left.map(transform),
                right: right.map(transform))
        }
    }

    func flatMap<U>(_ transform: (T) -> GooTree<U>) -> GooTree<U> where U: TreeMutatability {
        switch self {
        case .leaf(let value):
            return transform(value)
        case .node(let value, let left, let right):
            let newValue = transform(value)
            return .node(
                newValue.firstParent,
                left: left.flatMap(transform),
                right: right.flatMap(transform))
        }
    }
    func fold<U>(_ initial: U, _ combine: (U, T) -> U) -> U {
        switch self {
        case .leaf(let value):
            return combine(initial, value)
        case .node(let value, let left, let right):
            let afterValue = combine(initial, value)
            let afterLeft = left.fold(afterValue, combine)
            return right.fold(afterLeft, combine)
        }
    }

    var depth: Int {
        switch self {
        case .leaf:
            return 1
        case .node(_, let left, let right):
            return 1 + max(left.depth, right.depth)
        }
    }

    var isBalanced: Bool {
        switch self {
        case .leaf:
            return true
        case .node(_, let left, let right):
            return abs(left.depth - right.depth) <= 1
                && left.isBalanced
                && right.isBalanced
        }
    }
}
public class GooTreeClass<T: TreeMutatability> {
    private var root: GooTree<T>

    public struct Handle {
        private let ptr: UnsafeMutablePointer<Any>

        fileprivate init(_ value: Any) {
            self.ptr = .allocate(capacity: 1)
            self.ptr.initialize(to: value)
        }

        public func get<U>() -> U? {
            return ptr.pointee as? U
        }
        public func cleanup() {
            ptr.deinitialize(count: 1)
            ptr.deallocate()
        }
    }

    public init(root: T) {
        self.root = .leaf(root)
    }

    public init(value: T, left: GooTreeClass<T>, right: GooTreeClass<T>) {
        self.root = .node(value, left: left.root, right: right.root)
    }

    public var value: T {
        get { root.firstParent }
        set { root.firstParent = newValue }
    }

    public var children: (GooTreeClass<T>, GooTreeClass<T>)? {
        get {
            switch root {
            case .leaf:
                return nil
            case .node(_, let left, let right):
                return (
                    GooTreeClass<T>(root: left.firstParent),
                    GooTreeClass<T>(root: right.firstParent)
                )
            }
        }
        set {
            guard let newChildren = newValue else {
                root = .leaf(value)
                return
            }
            root = .node(
                value,
                left: .leaf(newChildren.0.value),
                right: .leaf(newChildren.1.value))
        }
    }

    public var depth: Int {
        root.depth
    }

    public var isBalanced: Bool {
        root.isBalanced
    }

    public func map<U: TreeMutatability>(_ transform: (T) -> U) -> Handle {
        let newTree = root.map(transform)
        return Handle(newTree)
    }

    ///
    // Could also add a convenience initializer

    func flatMap<U>(_ transform: (T) -> GooTree<U>) -> Handle {
        let newTree = root.flatMap(transform)
        return Handle(newTree)
    }

    func fold<U>(_ initial: U, _ combine: (U, T) -> U) -> U {
        return root.fold(initial, combine)
    }

}
