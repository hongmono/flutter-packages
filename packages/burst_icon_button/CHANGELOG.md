## 0.2.3

### Improvements
* Add example/main.dart for pub.dev example tab

## 0.2.2

### Improvements
* Add Live Demo link and pub.dev badge to README

## 0.2.1

### Bug Fixes
* **Type safety**: Add explicit type annotations to gesture callbacks (`TapDownDetails`, `TapUpDetails`, `LongPressStartDetails`, `LongPressEndDetails`)
* **Library directive**: Remove unnecessary `library burst_button;` directive that mismatched package name

### Performance
* **Tween hot-path**: Pre-compute `fadeAnimation` at icon creation instead of re-creating `Tween` on every animation frame
* **Random instance**: Use single module-level `Random` instance instead of creating one per burst icon

### Improvements
* Remove unused `GlobalKey` field from `_IconData`
* Fix LICENSE copyright holder
* Apply `dart format` to all files

## 0.2.0

### Features
* **burstCount**: Spawn multiple burst icons per tap (default 1)
* **burstDistance**: Configurable vertical travel distance (default 100.0)
* **burstCurve**: Custom animation curve (default `Curves.easeOut`)

### Bug Fixes
* **Timer disposal**: Fix timer not being cancelled in `dispose()`
* **Controller disposal**: Fix animation controllers in `_icons` list not being disposed on widget dispose
* **WidgetState**: Replace deprecated `WidgetState` with simple boolean
* **mounted check**: Add `mounted` guard before `setState` in animation listener

### Improvements
* Add comprehensive doc comments to all public API members
* Add 11 unit tests
* Migrate to `flutter-packages` monorepo

## 0.1.38

* Previous release from `flutter_interactions` repository
