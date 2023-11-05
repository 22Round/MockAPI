import Foundation

public enum InputError: Error, Equatable {
    case badEmail
    case badPassword
    case age
    case common(String)
    case unknown
}

extension InputError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .badEmail: return "Please input valide email"
        case .badPassword: return "Password should in range 6..12 chars"
        case .age: return "Age should be in range 18..99 years"
        case .common(let message): return "\(message)"
        case .unknown: return "Unknown Error"
        }
    }
}
