import SwiftUI

struct TimerView: View {
    @StateObject var vm = PomodoroViewModel()

    var body: some View {
        VStack(spacing: 24) {
            ProgressRing(progress: vm.progress, tint: Theme.work)
                .frame(width: 220, height: 220)
                .overlay(Text(timeString(vm.remaining)).font(.title2.monospacedDigit()))
            Text(vm.phase == .work ? NSLocalizedString("work", comment: "") : NSLocalizedString("break", comment: ""))
                .foregroundStyle(.secondary)
            HStack {
                Button(vm.isRunning ? NSLocalizedString("pause", comment: "") : NSLocalizedString("start", comment: "")) {
                    vm.isRunning ? vm.pause() : vm.start()
                }.buttonStyle(.borderedProminent)

                Button(NSLocalizedString("reset", comment: "")) { vm.reset() }
                    .buttonStyle(.bordered)
            }
        }
        .padding()
        .onAppear {
            BootDefaults.ensureInitialFiles()
            Task { await NotificationService.request() }
            vm.configure(work: 25*60, rest: 5*60)
        }
        .navigationTitle(NSLocalizedString("tab_timer", comment: ""))
    }

    private func timeString(_ s: Int) -> String {
        let m = s / 60, sec = s % 60
        return String(format: "%02d:%02d", m, sec)
    }
}