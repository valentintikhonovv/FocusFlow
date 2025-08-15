import Foundation

enum BootDefaults {
    static let defaultCategories: [Category] = [
        .init(name: "Work",   colorHex: "#4F46E5", icon: "laptopcomputer"),
        .init(name: "Study",  colorHex: "#10B981", icon: "book"),
        .init(name: "Fitness",colorHex: "#EF4444", icon: "figure.run"),
        .init(name: "Home",   colorHex: "#F59E0B", icon: "house"),
        .init(name: "Rest",   colorHex: "#0EA5E9", icon: "moon")
    ]

    static func ensureInitialFiles() {
        let fs = DI.fileStore
        if !fs.exists("categories.json") {
            try? fs.save("categories.json", defaultCategories)
        }
        if !fs.exists("settings.json") {
            let s = AppSettings(theme: "system", languageOverride: nil, schemaVersion: 1)
            try? fs.save("settings.json", s)
        }
    }

    static func monthFile(for date: Date = .init()) -> String {
        let comps = Calendar.current.dateComponents([.year, .month], from: date)
        return String(format: "sessions-%04d-%02d.json", comps.year ?? 0, comps.month ?? 0)
    }
}