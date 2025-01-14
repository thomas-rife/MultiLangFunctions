import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}

func firstThenLowerCase(of array: [String], satisfying predicate: (String) -> Bool) -> String? {
    return array.first(where: predicate)?.lowercased()
}

class Phrase {
    private var words: [String]
    
    init(_ words: [String] = []) {
        self.words = words
    }
    
    var phrase: String {
        return words.joined(separator: " ")
    }
    
    func and(_ word: String) -> Phrase {
        return Phrase(words + [word])
    }
}

func say(_ word: String = "") -> Phrase {
    return Phrase([word])
}

func meaningfulLineCount(_ filename: String) async -> Result<Int, Error> {
    do {
        let fileURL = URL(fileURLWithPath: filename)
        let meaningfulLines = try await withThrowingTaskGroup(of: Int.self) { group in
            let fileHandle = try FileHandle(forReadingFrom: fileURL)
            defer { try? fileHandle.close() }
            
            for try await line in fileHandle.bytes.lines {
                group.addTask {
                    let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                    return (!trimmedLine.isEmpty && !trimmedLine.hasPrefix("#")) ? 1 : 0
                }
            }
            
            return try await group.reduce(0, +)
        }
        return .success(meaningfulLines)
    } catch {
        return .failure(error)
    }
}

struct Quaternion: Equatable, CustomStringConvertible {
    let a: Double
    let b: Double
    let c: Double
    let d: Double

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    static let ZERO = Quaternion()
    static let I = Quaternion(b: 1)
    static let J = Quaternion(c: 1)
    static let K = Quaternion(d: 1)

    var coefficients: [Double] { [a, b, c, d] }

    var conjugate: Quaternion {
        Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    static func + (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    static func * (lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        Quaternion(
            a: lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d,
            b: lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c,
            c: lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b,
            d: lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        )
    }

    var description: String {
    var components: [String] = []
    
    if a != 0.0 {
        components.append(String(a))
    }
    
    if b != 0.0 {
        if b == 1.0 && components.isEmpty {
            components.append("i")
        } else if b == 1.0 && !components.isEmpty {
            components.append("+i")
        } else if b == -1.0 {
            components.append("-i")
        } else if b < 0.0 || components.isEmpty {
            components.append("\(b)i")
        } else {
            components.append("+\(b)i")
        }
    }
    
    if c != 0.0 {
        if c == 1.0 && components.isEmpty {
            components.append("j")
        } else if c == 1.0 && !components.isEmpty {
            components.append("+j")
        } else if c == -1.0 {
            components.append("-j")
        } else if c < 0.0 || components.isEmpty {
            components.append("\(c)j")
        } else {
            components.append("+\(c)j")
        }
    }
    
    if d != 0.0 {
        if d == 1.0 && components.isEmpty {
            components.append("k")
        } else if d == 1.0 && !components.isEmpty {
            components.append("+k")
        } else if d == -1.0 {
            components.append("-k")
        } else if d < 0.0 || components.isEmpty {
            components.append("\(d)k")
        } else {
            components.append("+\(d)k")
        }
    }
    
    if components.isEmpty {
        return "0"
    }
    
    return components.joined()
}
}

indirect enum BinarySearchTree {
    case empty
    case node(left: BinarySearchTree, value: String, right: BinarySearchTree)

    var size: Int {
        switch self {
        case .empty:
            return 0
        case .node(let left, _, let right):
            return 1 + left.size + right.size
        }
    }

    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(left: .empty, value: value, right: .empty)
        case .node(let left, let nodeValue, let right):
            if value < nodeValue {
                return .node(left: left.insert(value), value: nodeValue, right: right)
            } else if value > nodeValue {
                return .node(left: left, value: nodeValue, right: right.insert(value))
            } else {
                return self
            }
        }
    }

    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case .node(let left, let nodeValue, let right):
            if value < nodeValue {
                return left.contains(value)
            } else if value > nodeValue {
                return right.contains(value)
            } else {
                return true
            }
        }
    }
}

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty:
            return "()"
        case .node(let left, let value, let right):
            return "(\(nodeDescription(left, value, right)))"
        }
    }
    
    private func nodeDescription(_ left: BinarySearchTree, _ value: String, _ right: BinarySearchTree) -> String {
        let leftStr = subtreeDescription(left)
        let rightStr = subtreeDescription(right)
        return "\(leftStr)\(value)\(rightStr)"
    }
    
    private func subtreeDescription(_ tree: BinarySearchTree) -> String {
        switch tree {
        case .empty:
            return ""
        case .node(_, _, _):
            return "(\(tree.nodeDescription()))"
        }
    }
    
    private func nodeDescription() -> String {
        switch self {
        case .empty:
            return ""
        case .node(let left, let value, let right):
            return nodeDescription(left, value, right)
        }
    }
}