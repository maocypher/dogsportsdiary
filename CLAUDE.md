# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This App Does

Dog Sports Diary is a Flutter mobile app for tracking dog sports training. Users manage multiple dogs, log training sessions (duration, temperature, exercises, ratings), view history with statistics, and backup/restore data. UI is localized in English and German.

## Common Commands

```bash
# Dependencies
flutter pub get

# Code generation (run after modifying annotated models)
dart run build_runner build --delete-conflicting-outputs

# Lint (matches CI config)
flutter analyze --no-fatal-infos --no-fatal-warnings

# Tests
flutter test
flutter test test/unit_tests/           # unit tests only
flutter test test/widget_tests/         # widget tests only
flutter test test/unit_tests/dog_repository_test.dart  # single file

# Builds
flutter build apk --release
flutter build ios --release
flutter build ipa --release
```

## Architecture

### Layer Structure

```
lib/
  app/          - MaterialApp.router setup, theme
  core/         - DI (GetIt), navigation (go_router), cross-cutting services
  data/         - Hive repositories, adapters, local persistence
  domain/       - Entities (Dog, DiaryEntry), value objects (enums, Rating, Exercise)
  features/     - Feature modules, each with view + viewmodel
  presentation/ - Shared UI widgets
  l10n/         - ARB localization files (en, de)
```

### Key Patterns

**State management:** Provider (ChangeNotifier) + ViewModel per feature. ViewModels extend ChangeNotifier and are provided via `ChangeNotifierProvider`.

**DI:** GetIt service locator. All registrations are in `lib/core/di/service_provider.dart`. Repositories and services are registered as singletons; ViewModels are typically factory-registered per feature screen.

**Persistence:** Hive local NoSQL database. Each entity has a TypeAdapter registered during `HiveService.initAsync()` in `main.dart`. `HiveService.initAsync()` must complete before `ServiceProvider` is initialized.

**Navigation:** go_router with `StatefulShellRoute` for bottom tab navigation (Overview, Diary, Dogs, Settings). Routes defined in `lib/core/navigation/app_router.dart`.

**Repository pattern:** `DogRepository`, `DiaryEntryRepository`, `SettingsRepository` abstract data access. Concrete implementations use Hive boxes.

**Result type:** `multiple_result` package — functions return `Result<Success, Failure>` rather than throwing.

### Feature Module Structure

Each feature in `lib/features/<feature>/` typically contains:
- `<feature>_screen.dart` — the widget
- `<feature>_viewmodel.dart` — ChangeNotifier with business logic
- Any feature-specific widgets

### Testing

- `test/unit_tests/` — repository and viewmodel tests
- `test/widget_tests/` — widget/integration tests
- `test/common/factories/` — shared `TestFactories` for building test data
- `test/mocks.dart` — global mocktail mocks

Tests use **mocktail** for mocking, **faker** for data generation, and **hive_test** for Hive-specific testing.

## Flutter/Dart Notes

- Dart SDK: `>=3.4.0 <4.0.0`, Flutter 3.27.2 (see codemagic.yaml)
- `generate: true` in pubspec.yaml — localization classes are auto-generated into `.dart_tool/`
- App is portrait-only (locked in `main.dart`)
- `analysis_options.yaml` extends `flutter_lints`; treat warnings as non-fatal but fix them
