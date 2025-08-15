import Foundation

struct Category: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var colorHex: String
    var icon: String
}

struct Session: Codable, Identifiable, Hashable {
    var id = UUID()
    var categoryId: UUID
    var start: Date
    var end: Date?
    var minutes: Int
    var note: String?
    var isBreak: Bool
}

enum GoalScope: String, Codable { case day, week, month, year }

struct Goal: Codable, Identifiable, Hashable {
    var id = UUID()
    var scope: GoalScope
    var categoryId: UUID?
    var metric: String // "minutes" | "count"
    var target: Int
    var progress: Int
}

struct Reminder: Codable, Identifiable, Hashable {
    var id = UUID()
    var title: String
    var rrule: String
    var categoryId: UUID?
    var isEnabled: Bool
}

struct AppSettings: Codable {
    var theme: String // system/light/dark
    var languageOverride: String?
    var schemaVersion: Int
}