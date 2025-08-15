import StoreKit

@MainActor
final class SubscriptionManager: ObservableObject {
    @Published var isPro = false
    @Published var products: [Product] = []

    private let monthlyId = "focusflow.pro.monthly"
    private let annualId  = "focusflow.pro.annual"

    func loadProducts() async {
        do { products = try await Product.products(for: [monthlyId, annualId]) }
        catch { products = [] }
        await refreshEntitlement()
    }

    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            if case .success(let verification) = result {
                _ = try verification.payloadValue
                await refreshEntitlement()
            }
        } catch { /* TODO: show error */ }
    }

    func restore() async { try? await AppStore.sync(); await refreshEntitlement() }

    func refreshEntitlement() async {
        isPro = false
        for await t in Transaction.currentEntitlements {
            if case .autoRenewable = t.productType { isPro = true; break }
        }
    }
}