import SwiftUI

struct TodayView: View {
    @State private var doneMin = 0
    @State private var targetMin = 240

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ProgressRing(progress: progress, tint: Theme.work)
                    .frame(width: 180, height: 180)
                Text("\(NSLocalizedString("daily_goal", comment: "")): \(targetMin) min")
                    .foregroundStyle(.secondary)

                HStack {
                    QuickButton("Work 25") { /* open timer preset 25 */ }
                    QuickButton("Study 25") { /* open timer preset 25 */ }
                    QuickButton("Break 5") { /* open timer preset 5 */ }
                }

                NavigationLink(NSLocalizedString("tab_timer", comment: "")) {
                    TimerView()
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle(NSLocalizedString("tab_today", comment: ""))
        }
    }

    var progress: Double {
        targetMin == 0 ? 0 : min(1, Double(doneMin)/Double(targetMin))
    }
}

private struct QuickButton: View {
    let title: String; let action: () -> Void
    var body: some View {
        Button(title, action: action).buttonStyle(.bordered)
    }
}