Jal Setu - Flutter UI (MVC + GetX)

How to run:
- Ensure Flutter 3.22+ installed.
- From workspace root run:
  flutter pub get
  flutter run -d chrome OR your device

Structure:
- lib/models: data models
- lib/services: ApiService + MockApiService
- lib/controllers: GetX controllers
- lib/views: UI screens (tabs + shell)
- lib/utils: theme, validators

Notes:
- Uses Material 3, light/dark themes, animation transitions, rounded inputs, cards.
