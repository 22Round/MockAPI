import Foundation

public enum StorageError: Error, Equatable {
    case badURL
    case userAlreadyExist
    case userNotRegistered
    case wrongPassword
    case read
    case write
    case delete
    case unknown
}

extension StorageError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown: return "Unknown Error"
        case .badURL: return "Bad URL!"
        case .userAlreadyExist: return "User already exists"
        case .userNotRegistered: return "User isn't registerd"
        case .wrongPassword: return "Wrong Password"
        case .read: return "Error while reading"
        case .write: return "Error while writing"
        case .delete: return "Error on deleting storage"
        }
    }
}

class StorageService {
    func read<T: Codable>(filename: String) async throws -> T? {
        var file: URL
        var data: Data?

        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch  {
            throw error
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            throw error
        }

        guard data != nil else { return nil }

        do {
            let decoder = JSONDecoder()
            print("Reading...  📖: \(file.description)")
            return try decoder.decode(T.self, from: data!)
        } catch {
            throw error
        }
    }
    
    func write<T: Codable>(array: [T]?, filename: String) async throws {
        var file: URL
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            throw error
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            print("Writing...  📖: \(file.description)")
            try encoder.encode(array).write(to: file)
        } catch {
            throw error
        }
    }
    
    func delete(filename: String) async throws {
        do {
            let file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
            print("Deleting...  📖: \(file.description)")
            if FileManager.default.fileExists(atPath: file.path) {
                do {
                    try FileManager.default.removeItem(atPath: file.path)
                } catch {
                    throw error
                }
            }
        } catch {
            throw error
        }
    }
}
