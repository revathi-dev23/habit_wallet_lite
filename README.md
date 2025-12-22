# Habit Wallet Lite

A simple, offline-first personal finance manager (PFM) built with Flutter.

## Features
-   **Dashboard**: Monthly spending chart (Bar Chart) and recent transactions list.
-   **Transactions**: Add/Edit/View expenses and incomes with categories, notes, and dates.
-   **Offline-First**: Uses `drift` (SQLite) for local storage. Data is always available.
-   **Sync**: Background sync stub (simulated API calls) with conflict resolution logic (Last-Write-Wins).
-   **Auth**: Simple PIN-based authentication (Stub: '1234').
-   **Internationalization**: Support for English and Tamil.
-   **Notifications**: Daily reminder at 8 PM to log expenses.
-   **Deep Linking**: Open specific transactions via `app://tx/{id}`.
-   **Theming**: Light and Dark mode support.

## Architecture
This project follows **Clean Architecture** principles:
-   **Presentation**: UI (Widgets, Pages) and State Management (Riverpod).
-   **Domain**: Business Logic (Use Cases, Entities, Repositories Interfaces).
-   **Data**: Data Sources (Drift DB, API Service) and Repositories Implementation.

### Tech Stack
-   **Flutter**: UI Framework
-   **Riverpod**: State Management & DI
-   **Drift**: Local Database (SQLite)
-   **GoRouter**: Navigation
-   **Freezed**: Data Classes & Unions
-   **FL Chart**: Charts

## Setup
1.  **Prerequisites**: Flutter SDK, Android Device/Emulator.
2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Generate Code**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    # Or use the provided script on Windows:
    .\gen.bat
    ```
4.  **Run**:
    ```bash
    flutter run
    ```

## Tradeoffs & Stubbed Features
-   **Sync**: Fully functional local DB, but remote sync is simulated (`MockApiService`). In a real app, this would connect to a REST/GraphQL endpoint.
-   **Auth**: PIN verification is local-only stub. Secure storage is used, but a real auth flow would involve tokens.
-   **Attachments**: UI is present, but file picking logic is a stub due to "Lite" scope constraints.

## Profiling Notes
-   **Startup**: Optimized by lazy loading database and non-critical services.
-   **Jank**: List virtualization (`ListView.builder`) used for transactions. Chart rendering is optimized to handle monthly data.
-   **Size**: Proguard/R8 shrinking enabled for release builds.

## Testing
-   **Unit Tests**: `flutter test`
-   **CI**: GitHub Actions workflow included for automated analysis and testing.
