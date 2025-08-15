import SwiftUI

@main
struct FocusFlowApp: App {
    @StateObject private var sub = SubscriptionManager()

    var body: some Scene {
        WindowGroup {
            RootTabs()
                .environmentObject(sub)
                .task { await sub.loadProducts() }
        }
    }
}

struct RootTabs: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        TabView {
            TodayView()
                .tabItem { Label(NSLocalizedString("tab_today", comment: ""), systemImage: "sun.max") }

            TimerView()
                .tabItem { Label(NSLocalizedString("tab_timer", comment: ""), systemImage: "timer") }

            AnalyticsView()
                .tabItem { Label(NSLocalizedString("tab_analytics", comment: ""), systemImage: "chart.bar") }

            MoreView()
                .tabItem { Label(NSLocalizedString("tab_more", comment: ""), systemImage: "gearshape") }
        }
        .tint(.primary)
        .background(Theme.bg(for: colorScheme))
    }
}