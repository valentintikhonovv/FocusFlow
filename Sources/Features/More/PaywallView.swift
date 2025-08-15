import SwiftUI
import StoreKit

struct PaywallView: View {
    @EnvironmentObject var sub: SubscriptionManager

    var monthly: Product? { sub.products.first { $0.id.contains(".monthly") } }
    var annual: Product?  { sub.products.first { $0.id.contains(".annual") } }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text(NSLocalizedString("paywall_title", comment: "")).font(.title2).bold()
                Text(NSLocalizedString("paywall_bullets", comment: ""))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                if let a = annual {
                    Button("\(NSLocalizedString("annual_price", comment: "")) • \(a.displayPrice)") {
                        Task { await sub.purchase(a) }
                    }.buttonStyle(.borderedProminent)
                }
                if let m = monthly {
                    Button("\(NSLocalizedString("monthly_price", comment: "")) • \(m.displayPrice)") {
                        Task { await sub.purchase(m) }
                    }.buttonStyle(.bordered)
                }

                Text(NSLocalizedString("try_free_3_days", comment: "")).font(.footnote).foregroundStyle(.secondary)

                Button(NSLocalizedString("restore_purchases", comment: "")) {
                    Task { await sub.restore() }
                }.font(.footnote)

                Spacer()
            }
            .padding()
            .navigationTitle("Pro")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button("Close") { dismiss() } }
            }
        }
    }

    @Environment(\.dismiss) private var dismiss
}