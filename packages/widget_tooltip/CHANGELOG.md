## 1.4.1

### Improvements
* Add example/main.dart for pub.dev example tab

## 1.4.0

### Features
* **Barrier / Backdrop**: Add `TooltipBarrier` config for semi-transparent overlay with optional gaussian blur effect. Supports touch-through areas for guided tours.
* **Close Button**: Add `TooltipCloseButton` config with `inside`/`outside` positioning, customizable color and size. Includes accessibility support.
* **Shadows**: Add `shadows` parameter for adding box shadows without modifying `messageDecoration`.
* **Decoration Builder**: Add `decorationBuilder` callback for fully custom tooltip decoration.
* **Separate Animation Durations**: Add `showAnimationDuration` and `hideAnimationDuration` for independent show/hide animation timing.
* **Mouse Cursor**: Add `mouseCursor` parameter to customize hover cursor style.
* **onLongPress**: Add `onLongPress` callback for tooltip content long press events.

### Deprecations
* `touchThroughArea`, `touchThroughAreaShape`, `touchThroughAreaCornerRadius` on `WidgetTooltip` — use `TooltipBarrier.touchThroughArea` instead.

### Improvements
* Cache `MediaQuery` result in layout calculation to avoid redundant lookups
* Consolidate dismiss mode checking logic into `_matchesDismissMode` helper
* Extract `_syncAnimationDurations` helper to eliminate duplication
* Consolidate `_buildCombinedTooltip` switch branches into unified structure
* Barrier fades in/out with the tooltip animation

## 1.3.2

### Improvements
* Add Live Demo link to README

## 1.3.1

### Bug Fixes
* **Semantics hint**: Fix tap trigger mode incorrectly showing "Double tap to show tooltip" instead of "Tap to show tooltip"
* **TooltipGroup**: Fix potential concurrent modification in `dismissAll()` and `_dismissOthers()` by iterating over a defensive copy
* **Triangle painter**: Remove dead `strokeWidth` and `strokeCap` properties that had no effect with `PaintingStyle.fill`

### Improvements
* Add deprecation ignore comment for `SemanticsService.announce` with migration note for Flutter 3.35+
* Fix LICENSE copyright holder
* Apply `dart format` to all files

## 1.3.0

### Features
* **TooltipGroup**: Add `TooltipGroup` class to ensure only one tooltip is visible at a time within a group. Use `TooltipController(group: group)` to link controllers.
* **dismissOnScroll**: Add `dismissOnScroll` property (default `true`) to automatically dismiss the tooltip when the nearest `Scrollable` ancestor scrolls.

### Bug Fixes
* **mounted check**: Add `mounted` guard in post-frame callback to prevent crashes when widget is disposed between phases.
* **overlay cleanup**: Improve overlay removal safety with dedicated `_removeOverlay()` method.

### Improvements
* **Code refactoring**: Extract `_calculateLayout` into smaller methods (`_resolveAnchors`, `_resolveOffsets`) for better readability.
* **Typed layout result**: Replace anonymous record with `_TooltipLayout` class for clarity.
* **Extract overlay building**: Move final overlay construction to `_insertFinalOverlay` and `_buildCombinedTooltip` methods.

## 1.2.2

### Bug Fixes
* **direction in ListView**: Fix `direction` parameter being ignored inside `ListView` and other scrollable widgets ([#7](https://github.com/hongmono/widget_tooltip/issues/7))
* **tooltip positioning**: Fix tooltip appearing near screen center instead of target due to incorrect measurement constraints
* **scale animation**: Fix scale animation not working — now triangle and message box animate as a unified element

### Improvements
* **Two-phase positioning**: Restore proven measure-then-position approach for reliable tooltip placement
* **Combined tooltip element**: Triangle and message box are now a single composite widget, ensuring consistent animation behavior
* **ListView example**: Add ListView tab to example app for testing scroll scenarios

## 1.2.1

### Improvements
* **Unified tooltip widget**: Merge triangle and message box into a single widget for smoother animations
* **Better scale animation**: Scale animation now expands from a single center point instead of separately
* **Code simplification**: Remove `triangleOffset` calculation and `kTriangleOverlapOffset` constant

## 1.2.0

### Features
* **autoFlip**: Add `autoFlip` property to automatically flip tooltip direction when there's not enough space at screen edges
* **hover**: Add `WidgetTooltipTriggerMode.hover` for Desktop/Web mouse hover support

### Breaking Changes
* **messageStyle removed**: Remove unused `messageStyle` property

### Deprecations
* **tapAnyWhere**: Deprecate `WidgetTooltipDismissMode.tapAnyWhere` in favor of `tapAnywhere` (correct spelling)

### Bug Fixes
* **autoFlip**: Simplified logic - now uses screen center to determine tooltip position (target in top half → tooltip below, target in bottom half → tooltip above)
* **visibility**: Auto-dismiss tooltip when target scrolls off-screen

### Improvements
* Add comprehensive documentation for `TooltipController` and `WidgetTooltip` classes
* Refactor internal variable names for better code readability
* Remove unused `isLeft`/`isRight` parameters from internal `_TooltipOverlay` widget
* Improve example app with better styling and demonstrations

## 1.1.4
* *Bug fixed*: Fix right padding not working when text is long

## 1.1.3

### Features
* **Documentation**: Improve documentation and examples.

## 1.1.2

### Features
* **Performance**: Improve performance and stability.

## 1.1.1

### Features
* **Bug fixes**: Fix minor bugs and improve stability.

## 1.1.0

### Features
* **triangleRadius**: Add new property to set the radius of the triangle.

## 1.0.0

### Features
* **Widget Tooltip**: Add new widget to display a tooltip.
