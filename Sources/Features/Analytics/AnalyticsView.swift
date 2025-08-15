import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Coming soon: charts & streaks").foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .navigationTitle(NSLocalizedString("tab_analytics", comment: ""))
        }
    }
}