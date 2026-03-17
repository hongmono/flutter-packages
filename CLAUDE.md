# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Flutter packages monorepo managed with **Melos** (v7.0.0) and **Dart pub workspaces**. Contains publishable Flutter widget packages and a shared example app.

- **Dart SDK**: `>=3.6.0 <4.0.0`
- **Flutter**: `>=3.10.0`
- **Flutter version manager**: FVM (stable channel)
- **Linting**: `flutter_lints` (^6.0.0) via `package:flutter_lints/flutter.yaml`

## Common Commands

```bash
# Install dependencies (from root)
flutter pub get

# Analyze all packages
dart analyze .

# Format all code
dart format .

# Run tests for a specific package
cd packages/widget_tooltip && flutter test
cd packages/burst_icon_button && flutter test
cd packages/draggable_float && flutter test

# Run a single test file
flutter test test/widget_tooltip_test.dart

# Run the example app
cd apps/example && flutter run
```

These commands are also available as Melos scripts (`analyze`, `test`, `format`) defined in the root `pubspec.yaml`.

## Architecture

```
packages/
  widget_tooltip/      # Customizable tooltip widget (pub.dev published)
  burst_icon_button/   # Icon button with burst animation (pub.dev published)
  draggable_float/     # Draggable floating widget (pub.dev published)
apps/
  example/             # Demo app showcasing all packages
```

Each package follows the same structure:
- `lib/<package_name>.dart` — public API barrel export
- `lib/src/` — implementation files (not exported directly)
- `test/` — widget tests using `flutter_test`

All packages use `resolution: workspace` in their pubspec.yaml, linking them to the root workspace.

## Publishing

Packages are published to pub.dev via GitHub Actions using tag-based triggers. Tag format: `<package-name>-v<version>` (e.g., `widget_tooltip-v1.3.0`). The workflow uses dart-lang reusable workflow with OIDC authentication — no manual token management.

## Testing Patterns

Tests use `testWidgets` with a helper function (e.g., `buildTestApp()`) that wraps widgets in `MaterialApp` + `Scaffold`. Tests exercise gestures (`tester.tap`, `tester.startGesture`, `tester.timedDragFrom`) and animations (`tester.pumpAndSettle`). CI currently only runs widget_tooltip tests.
