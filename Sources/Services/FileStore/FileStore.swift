import Foundation

final class FileStore {
    private let fm = FileManager.default
    private let baseURL: URL

    init() {
        let appSup = try! fm.url(for: .applicationSupportDirectory,
                                 in: .userDomainMask,
                                 appropriateFor: nil,
                                 create: true)
        let dir = appSup.appendingPathComponent("FocusFlow", isDirectory: true)
        try? fm.createDirectory(at: dir, withIntermediateDirectories: true)
        baseURL = dir
    }

    func url(_ name: String) -> URL { baseURL.appendingPathComponent(name) }

    func exists(_ name: String) -> Bool { fm.fileExists(atPath: url(name).path) }

    func save<T: Encodable>(_ name: String, _ value: T) throws {
        let u = url(name)
        let data = try JSONEncoder().encode(value)
        let tmp = u.appendingPathExtension("tmp")
        try data.write(to: tmp, options: .atomic)
        if fm.fileExists(atPath: u.path) { try fm.removeItem(at: u) }
        try fm.moveItem(at: tmp, to: u)
    }

    func load<T: Decodable>(_ name: String, as type: T.Type) throws -> T {
        let u = url(name)
        let data = try Data(contentsOf: u)
        return try JSONDecoder().decode(T.self, from: data)
    }
}