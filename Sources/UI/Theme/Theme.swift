import SwiftUI

enum AppTheme: String, Codable { case system, light, dark }

enum Theme {
    static func bg(for cs: ColorScheme) -> Color { cs == .dark ? .black : .white }
    static let work = Color(hex: "#4F46E5")
    static let study = Color(hex: "#10B981")
    static let fitness = Color(hex: "#EF4444")
    static let home = Color(hex: "#F59E0B")
    static let rest = Color(hex: "#0EA5E9")
}

extension Color {
    init(hex: String) {
        let hex = hex.dropFirst(hex.hasPrefix("#") ? 1 : 0)
        var int = UInt64()
        Scanner(string: String(hex)).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xff)/255
        let g = Double((int >> 8) & 0xff)/255
        let b = Double(int & 0xff)/255
        self = Color(red: r, green: g, blue: b)
    }
}