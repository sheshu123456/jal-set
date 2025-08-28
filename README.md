# Jal Setu (Flutter)

Material 3 Flutter app skeleton for a utility service portal (MGX Jal Setu inspired). Implements MVC structure with GetX state management.

## Features
- Modern Material 3 theming (light/dark)
- Bottom navigation: Dashboard, Form, History, Profile
- Reactive forms with validation
- Cards, chips, animated buttons
- GetX controllers + mock service for demo data
- API-ready via `services/api_service.dart`

## Structure
```
lib/
  controllers/
  models/
  services/
  utils/
  views/
    sections/
  widgets/
```

## Run
```
flutter pub get
flutter run
```

Replace mock implementations with real API calls in `services/` and wire endpoints in controllers.
