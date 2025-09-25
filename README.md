# cinex_app

cinex_app is a Flutter demo application I built as the first-round project for a company's selection process. The goal was to demonstrate a production-minded app structure, clear separation of concerns, and practical use of common Flutter ecosystem tools (state management, DI, local storage, Firebase, networking and offline handling).

This README explains how the project is organized, the main implementation choices, and how to run and test the app so a reviewer can quickly understand what was implemented and why.

## High-level summary

- Purpose: Demonstrate a clean, testable Flutter app with remote data (Firebase & HTTP), local caching, dependency injection, and BLoC-based state management.
- Architecture: Clean Architecture-inspired layering (presentation, domain-ish logic, data/repositories) with dependency injection using `get_it`.
- Key packages used: `flutter_bloc`, `get_it`, `hive`, `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_messaging`, `http`, `connectivity_plus`, `cached_network_image`, `flutter_dotenv` and `lottie`.

See `pubspec.yaml` for exact package versions used in the project.

## Project structure (important files/folders)

- `lib/main.dart` - app entrypoint and top-level initialization (DI, Firebase, Hive, env loading).
- `lib/presentation/` - UI code, screens and BLoCs (presentation layer).
- `lib/common/` - shared widgets, helpers, loaders, and theme utilities.
- `lib/data/` - repositories, API clients and local storage adapters (Hive) that talk to Firebase / HTTP.
- `lib/generated/` - generated code (if any generated assets or localization exist).
- `assets/` - images, fonts and animations used in the app.

This structure follows a pragmatic Clean Architecture approach where UI depends on presentation/state classes, which depend on repositories/interfaces, and repositories contain the concrete implementations (remote and local).

## Architecture & design choices

- Clean-ish layering: The code separates presentation and data concerns. BLoCs (via `flutter_bloc`) handle UI state and orchestrate calls to repository interfaces. Repositories hide whether the data comes from Firebase, a REST API, or local cache.
- Dependency Injection: `get_it` is used as a simple service locator. All app-level singletons (repositories, API clients, Hive boxes) are registered at startup so classes can obtain dependencies via constructor injection or by looking up types in tests.
- State Management: `flutter_bloc` manages feature state (loading, success, error) and makes business logic testable through small, focused BLoCs.
- Local persistence: `hive` is used for lightweight, fast local storage and caching of frequently used objects (for example: user settings, cached API responses, auth tokens). `path_provider` is used to find a safe local path for persistent stores when needed.
- Networking & offline: `http` is used for REST calls and `connectivity_plus` is consulted before calls to provide basic offline detection and user-friendly error states. Network calls are wrapped and exposed by repository methods that implement retry/error handling.
- Firebase integration: `firebase_core` initializes Firebase. The project includes `firebase_auth` for authentication, `cloud_firestore` for data storage, and `firebase_messaging` for push notifications. The Android `google-services.json` file is present under `android/app` (ensure you add platform-specific config for iOS when needed).
- Environment configuration: `flutter_dotenv` loads a `.env` file for API keys / endpoints so secrets/config don't live in source control.
- Image caching & UI polish: `cached_network_image` for performant image loading and caching, `lottie` for subtle animations, and custom fonts in the `assets/fonts/` directory to present a polished UI.

## How things are implemented (concrete patterns)

- Initialization (recommended pattern used in `main.dart`):
	- Load environment variables with `flutter_dotenv`.
	- Initialize Hive and register adapters.
	- Initialize Firebase (`Firebase.initializeApp()`).
	- Register repositories, API clients and BLoC factories in `get_it`.

- Repository pattern:
	- Each feature exposes an abstract repository interface. Example: `AuthRepository` with methods `signIn`, `signOut`, `currentUser`.
	- Implementation classes (e.g., `AuthRepositoryImpl`) talk to Firebase Auth or Firestore and optionally cache results in Hive.

- BLoC pattern and UI:
	- Presentation uses `BlocProvider` / `BlocBuilder` to provide and react to state.
	- BLoCs emit loading / success / failure states. UI shows loaders (custom loader widgets) while waiting and friendly error UIs when requests fail.

- API calls & error handling:
	- Remote calls use the `http` package (wrapped by an `ApiClient` class) for any non-Firebase endpoints.
	- Calls check `connectivity_plus` before attempting network requests and surface appropriate offline messages.
	- All network errors are caught and logged with `debugPrint`. User-facing errors are shown via the UI.

- Local cache strategy:
	- Frequently-read and session data is cached in Hive boxes to reduce round-trips and provide basic offline UX.
	- Cached data has simple invalidation policies (time-based or updated on successful remote fetch) depending on the feature.

## Firebase specifics

- Auth: `firebase_auth` is used for sign-in flows. The repository handles token/session persistence so the UI can restore a signed-in session on startup.
- Firestore: `cloud_firestore` stores application data (for example user profiles or app-specific collections). Repositories expose high-level methods for CRUD operations.
- Messaging: `firebase_messaging` is configured to receive push notifications and handle background messages when possible. Platform-specific setup (Android `google-services.json` and iOS config) is required to enable this fully.

Note: The project includes `android/app/google-services.json` for Android. If you run on iOS, make sure to provide the iOS Firebase plist and enable push capabilities.

## Tests

- There are basic unit/widget tests under the `test/` folder (for example `date_formatter_test.dart`, `widget_test.dart`). They demonstrate testing of pure logic and widget smoke tests.

## Running the project locally

Prerequisites:
- Flutter SDK (version compatible with the project's SDK constraint in `pubspec.yaml`).
- An Android/iOS simulator or a connected device.
- (Optional) Firebase CLI and Firebase project configured if you want end-to-end Firebase features.

Quick start:

1. Install packages:

```powershell
flutter pub get
```

2. Add environment variables:
	- Copy the provided `.env` (if it exists) or create your own `.env` at project root. The app expects API keys or base endpoints in this file.

3. Ensure Firebase is configured for the platform you target:
	- Android: `android/app/google-services.json` is already present in the project.
	- iOS: add the GoogleService-Info.plist to `ios/Runner` and configure capabilities for push notifications.

4. Run the app:

```powershell
flutter run
```

5. Run tests:

```powershell
flutter test
```

## Observability, logging & debugging

- The app uses `debugPrint` for developer logs and follows the pattern of catching errors in BLoCs and logging them. You can extend logging with packages like `logger` or remote crash reporting (Sentry, Firebase Crashlytics) when needed.

## What a reviewer should look at

- `lib/main.dart` — start-up flow (DI, Hive, Firebase init).
- `lib/data/` — repository implementations that show how Firebase and HTTP calls are wrapped and cached.
- `lib/presentation/` — example of BLoC usage, UI state handling, and error/loading UX.
- Tests in `test/` — to see how business logic is validated.

## Next steps / possible improvements

- Add more unit and widget tests for BLoCs and repositories.
- Add CI (GitHub Actions) to run `flutter test` and static analysis on PRs.
- Introduce stronger typing for stored Hive objects and automatic migration strategy.
- Add Crashlytics / remote logging for production diagnostics.

## Contact / notes

If you review this project and want to run it or ask questions, open an issue in the repo or reach out to me. The code is intentionally small and focused to make the review quick and to highlight architecture and engineering choices.

---

Generated on: see repository commit history for exact state.
