import Foundation

@MainActor
final class PomodoroViewModel: ObservableObject {
    enum Phase { case work, rest }
    @Published var phase: Phase = .work
    @Published var remaining: Int = 25*60
    @Published var isRunning = false

    var workSec = 25*60
    var restSec = 5*60
    private var timer: Timer?

    func configure(work: Int, rest: Int) {
        workSec = work; restSec = rest; reset()
    }

    func start() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { await self?.tick() }
        }
    }
    func pause() { isRunning = false; timer?.invalidate() }
    func reset() { pause(); remaining = (phase == .work ? workSec : restSec) }

    private func tick() async {
        if remaining > 0 { remaining -= 1 }
        else { await switchPhase() }
    }

    private func switchPhase() async {
        phase = (phase == .work ? .rest : .work)
        reset()
        start()
        await NotificationService.schedule(title: phase == .work ? "Work started" : "Break started", after: 0.5)
    }

    var total: Int { phase == .work ? workSec : restSec }
    var progress: Double { 1 - Double(remaining)/Double(total) }
}