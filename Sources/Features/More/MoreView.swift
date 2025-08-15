import SwiftUI
import StoreKit

struct MoreView: View {
    @EnvironmentObject var sub: SubscriptionManager
    @State private var showPaywall = false

    var body: some View {
        NavigationStack {
            List {
                Section("Theme") {
                    Text("System / Light / Dark (soon)")
                }
                Section("Pro") {
                    HStack {
                        Text(sub.isPro ? "Pro Active" : "Free")
                        Spacer()
                        Button(sub.isPro ? "Manage" : NSLocalizedString("subscribe", comment: "")) {
                            showPaywall = true
                        }
                    }
                }
                Section {
                    Button(NSLocalizedString("restore_purchases", comment: "")) { Task { await sub.restore() } }
                }
            }
            .navigationTitle(NSLocalizedString("tab_more", comment: ""))
            .sheet(isPresented: $showPaywall) {
                PaywallView()
                    .environmentObject(sub)
            }
        }
    }
}