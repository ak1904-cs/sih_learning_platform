# {SIH} Learning Platform

A Flutter-based learning platform starter app with Firestore seeding utilities and multi-platform support (mobile, web, desktop).

## Key features

- Cross-platform Flutter app scaffold (Android, iOS, web, Windows, macOS, Linux)
- Firestore seed generator and CLI seeding tools
- Example seed payloads, security rules, and index configuration included
- Simple project layout suitable for extension into a production app

## Requirements

- Flutter SDK (stable)
- Dart SDK (bundled with Flutter)
- Firebase CLI (for deployment or emulator)
- Android Studio / Xcode for platform-specific builds (optional)

## Quick start (Windows)

1. Install Flutter and the Firebase CLI per their official docs.
2. From the repository root, fetch dependencies:

    flutter pub get

3. Run the app on a connected device or emulator:

    flutter run

4. Run tests:

    flutter test

## Firestore seeding

- Inspect example payloads: firestore_seed.json and assets/data.json
- Generate seed data:

    dart run generate_seed.dart

- Seed Firestore via the included CLI:

    dart run seed_firestore_cli.dart --help

Or run the CLI package directly:

    cd firestore_seed_cli
    dart pub get
    dart run bin/main.dart --help

Refer to firestore_seed_cli/README.md for flags and usage examples.

## Firebase setup & deployment

- Ensure firebase CLI is authenticated and project is selected:

    firebase login
    firebase use <project-id>

- Deploy rules/indexes or use the emulator for local development:

    firebase deploy --only firestore:rules
    firebase emulators:start --only firestore,auth

## Development notes

- Add assets to assets/ and register them in pubspec.yaml.
- Keep seed payloads and generator scripts in sync when changing data models.
- Update firestore.rules and firestore.indexes.json when schema or query patterns change.

## Contributing

- Fork, create a branch, add changes and tests, then open a pull request.
- Run tests and verify the app builds on target platforms before merging.

## Troubleshooting

- If Firebase errors occur, confirm the active project in .firebaserc and that you are logged in to the Firebase CLI.
- For platform-specific build issues, open the corresponding folder (android/, ios/) and use platform tools (Android Studio, Xcode) to diagnose.
