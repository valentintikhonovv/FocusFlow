# FocusFlow (iOS, SwiftUI) — без Xcode на локале

## Как собрать без Xcode
1) Залей репозиторий на GitHub.
2) GitHub Actions (.github/workflows/ios-sim-build.yml) сам:
   - установит XcodeGen,
   - сгенерирует .xcodeproj,
   - соберёт под iOS Simulator и выложит артефакт **FocusFlow.app**.
3) Зайди в Actions → последний ран → Download artifact.

> Для реального .ipa (устройство/App Store) нужны сертификаты/Provisioning и шаги подписи.

## Что внутри
- SwiftUI-приложение (табы), таймер Pomodoro, кольцо прогресса, пэйволл (StoreKit 2), локализация 5 языков, офлайн JSON-хранилище.
- Темы: светлая/тёмная (черный/белый UI), цветные индикаторы.

## Следующие шаги
- Добавить аналитику (чарты), список сессий и сохранение в JSON.
- Включить продукты в App Store Connect: `focusflow.pro.monthly`, `focusflow.pro.annual` с 3-дн. Trial.