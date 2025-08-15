import SwiftUI

struct ProgressRing: View {
    var progress: Double // 0...1
    var lineWidth: CGFloat = 14
    var tint: Color

    var body: some View {
        ZStack {
            Circle().stroke(.quaternary, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(tint, style: .init(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.6), value: progress)
            Text("\(Int(progress*100))%").font(.headline.monospacedDigit())
        }
        .accessibilityLabel("Progress")
        .accessibilityValue("\(Int(progress*100)) percent")
    }
}