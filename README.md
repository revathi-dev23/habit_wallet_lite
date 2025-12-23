
# Habit Wallet Lite
[![Flutter CI](https://github.com/revathi-dev23/habit_wallet_lite/actions/workflows/main.yml/badge.svg)](https://github.com/revathi-dev23/habit_wallet_lite/actions/workflows/main.yml)

A simple, offline-first personal finance manager (PFM) built with Flutter.

## Features
-   **Visual Dashboard**: Clear summary with a dynamic balance card and interactive daily spending chart.
-   **Transaction Management**: Add/Edit/View/Delete transactions with category picking, custom notes, and file attachments.
-   **Offline-First**: Powered by `Drift` (SQLite) for reliable local storage. Works 100% offline.
-   **Auto-Sync**: Background sync mechanism that automatically pushes local changes when the network is restored.
-   **Security**: Minimalist PIN-entry system with "Remember Me" using `flutter_secure_storage`.
-   **Localization**: Support for English and Tamil.
-   **Deep Linking**: Open specific transactions via `app://tx/{id}`.
-   **Reminders**: Daily local notifications to encourage consistent tracking.

## Architecture

The project follows a modular Clean Architecture approach:

- **Presentation**: UI (Widgets, Pages), State Management (Riverpod), Navigation (GoRouter)
- **Domain**: Business logic (Use Cases, Entities, Repository Interfaces)
- **Data**: Implementations, Local SQLite (Drift), and Remote Mock API.

### Tech Stack
-   **Flutter**: Cross-platform SDK
-   **Riverpod**: State management & DI
-   **Drift**: Type-safe local database
-   **GoRouter**: Declarative routing
-   **FL Chart**: Performance-optimized charts
-   **Connectivity Plus**: Real-time network monitoring for auto-sync

## Setup

1.  **Dependencies**:
    ```bash
    flutter pub get
    ```
2.  **Code Generation**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
3.  **Run**:
    ```bash
    flutter run
    ```

## Design Decisions

### Sync Strategy
The application uses an **Offline-First** strategy. Transactions are committed instantly to the local SQLite database to ensure zero UI lag. A background sync service monitors connectivity and handles data reconciliation with the mock server using a Last-Write-Wins (LWW) conflict resolution policy.

### Performance
- **Lazy Loading**: Database and heavy providers are initialized only when needed.
- **Virtualized Lists**: Used `ListView.builder` to handle large transaction histories efficiently.
- **Optimized Charts**: Drawing logic is constrained to monthly views for better frame rates.

## Future Road-map
- **Real API Integration**: Moving from the `MockApiService` to a live REST/GraphQL backend.
- **Biometric Auth**: Adding Fingerprint/FaceID support.
- **Budgeting**: User-defined budget limits per category.
- **Reporting**: PDF and CSV export functionality.

## License
MIT

