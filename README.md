# QI Agent SS App

Flutter mobile app for monitoring and managing SS (Sistem Saran) submissions and ESIC TM data. Built for PT Pamapersada Nusantara.

## Features

- **Dashboard** — SS stats, monthly bar chart, ESIC summary, coverage per crew
- **SS List** — search, filter by status/grade, paginated
- **ESIC TM** — snapshot per user, document access metrics
- **Approval PIN** — generate 6-digit PIN, countdown timer, tap-to-copy
- **Dept Dashboard** — team leader view with daily chart + dept stats
- **Manpower Management** (admin only) — CRUD manpower, coverage per crew with progress bars
- **Theme Switcher** — Slate / Indigo / Teal, persisted
- **Forced Update** — version check dialog, app locked if outdated

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Dart 3.x |
| Framework | Flutter |
| State Management | Riverpod (riverpod_annotation, codegen) |
| Routing | GoRouter |
| HTTP | Dio, Retrofit-style Interceptors |
| Storage | flutter_secure_storage, SharedPreferences |
| Architecture | Clean Architecture (feature-first) |
| Backend | FastAPI + JWT (separate repo) |

## Architecture

```
lib/
├── core/           # constants, network, router, theme, widgets
├── features/
│   ├── auth/       # login, JWT token, secure storage
│   ├── dashboard/  # stats, monthly chart, coverage card
│   ├── ss/         # SS list, search, filter
│   ├── esic/       # ESIC snapshots
│   ├── approval/   # PIN generation
│   ├── department/ # dept dashboard
│   ├── manpower/   # CRUD + coverage (admin only)
│   └── settings/   # theme picker
└── main.dart       # entry point, provider scope
```

## Build

```bash
# Debug
flutter build apk --debug

# Release (requires keystore)
flutter build apk --release
```

APK output: `build/app/outputs/flutter-apk/app-release.apk`

## Environment

Base URL configurable in `lib/core/constants/app_constants.dart`:

```dart
static const String baseUrl = 'https://qi.mibt.my.id/api';
```

## Versioning

- Version + build number from `pubspec.yaml`
- Forced update checks `/api/update` endpoint
- Server returns `{ "min_version": "x.y.z", "latest_url": "..." }`

---

**Repo:** [github.com/yordanb/qi-agent-ss-app](https://github.com/yordanb/qi-agent-ss-app)
