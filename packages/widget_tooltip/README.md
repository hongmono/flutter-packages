[English](README.md) | [한국어](README_ko.md)

# Widget Tooltip

A highly customizable tooltip widget for Flutter applications with smart positioning, multiple trigger modes, and rich styling options.

[![pub package](https://img.shields.io/pub/v/widget_tooltip.svg)](https://pub.dev/packages/widget_tooltip)
[![likes](https://img.shields.io/pub/likes/widget_tooltip)](https://pub.dev/packages/widget_tooltip/score)
[![popularity](https://img.shields.io/pub/popularity/widget_tooltip)](https://pub.dev/packages/widget_tooltip/score)
[![pub points](https://img.shields.io/pub/points/widget_tooltip)](https://pub.dev/packages/widget_tooltip/score)

**[Live Demo](https://hongmono.github.io/flutter-packages/)**

## Features

### Trigger Modes

Supports multiple ways to show tooltips:

| Mode | Description |
|------|-------------|
| `tap` | Show on tap |
| `longPress` | Show on long press |
| `doubleTap` | Show on double tap |
| `hover` | Show on mouse hover (Desktop/Web) |
| `manual` | Control programmatically |

### Smart Positioning

Tooltip automatically positions based on screen location:
- Target in **top half** → tooltip appears **below**
- Target in **bottom half** → tooltip appears **above**

Use `autoFlip: false` with `direction` to fix position.

### Directions

Control tooltip placement with `direction` and `axis`.

### Dismiss Modes

| Mode | Description |
|------|-------------|
| `tapAnywhere` | Dismiss by tapping anywhere (default) |
| `tapOutside` | Dismiss only when tapping outside tooltip |
| `tapInside` | Dismiss only when tapping the tooltip |
| `manual` | Dismiss only via controller |

### Custom Styling

Full control over appearance with `messageDecoration`, `triangleColor`, `messagePadding`, and more.

### Barrier / Backdrop

Display a semi-transparent overlay behind the tooltip with optional gaussian blur effect. Great for guided tours and onboarding.

### Close Button

Built-in close button with `inside` or `outside` positioning.

### Shadows

Dedicated `shadows` parameter for adding box shadows without modifying `messageDecoration`.

### Decoration Builder

Use `decorationBuilder` for fully custom tooltip appearance — wrap the message with any widget.

### Separate Animation Durations

Different timing for show and hide animations via `showAnimationDuration` and `hideAnimationDuration`.

### Touch-Through Area

Allow touch events to pass through a specific area of the barrier — useful for guided tours.

## Installation

```yaml
dependencies:
  widget_tooltip: ^1.2.2
```

```bash
flutter pub add widget_tooltip
```

## Quick Start

### Basic Usage

```dart
import 'package:widget_tooltip/widget_tooltip.dart';

WidgetTooltip(
  message: Text('Hello!'),
  child: Icon(Icons.info),
)
```

### Trigger Modes

```dart
// Tap to show
WidgetTooltip(
  message: Text('Tap triggered'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  child: Icon(Icons.touch_app),
)

// Hover (Desktop/Web)
WidgetTooltip(
  message: Text('Hover triggered'),
  triggerMode: WidgetTooltipTriggerMode.hover,
  child: Icon(Icons.mouse),
)
```

### Manual Control

```dart
final controller = TooltipController();

WidgetTooltip(
  message: Text('Controlled tooltip'),
  controller: controller,
  triggerMode: WidgetTooltipTriggerMode.manual,
  dismissMode: WidgetTooltipDismissMode.manual,
  child: Icon(Icons.info),
)

// Show/hide programmatically
controller.show();
controller.dismiss();
controller.toggle();
```

### Fixed Direction

```dart
// Always show above target
WidgetTooltip(
  message: Text('Always on top'),
  direction: WidgetTooltipDirection.top,
  autoFlip: false,  // Disable auto positioning
  child: Icon(Icons.arrow_upward),
)

// Horizontal tooltip
WidgetTooltip(
  message: Text('On the right'),
  direction: WidgetTooltipDirection.right,
  axis: Axis.horizontal,
  autoFlip: false,
  child: Icon(Icons.arrow_forward),
)
```

### Custom Styling

```dart
WidgetTooltip(
  message: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.check, color: Colors.white),
      SizedBox(width: 8),
      Text('Success!'),
    ],
  ),
  triggerMode: WidgetTooltipTriggerMode.tap,
  messageDecoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.3),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
  ),
  triangleColor: Colors.green,
  messagePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  child: Icon(Icons.info),
)
```

### Auto Dismiss

```dart
WidgetTooltip(
  message: Text('Disappears in 2 seconds'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  autoDismissDuration: Duration(seconds: 2),
  child: Icon(Icons.timer),
)
```

### Animations

```dart
WidgetTooltip(
  message: Text('Scale animation'),
  animation: WidgetTooltipAnimation.scale,
  animationDuration: Duration(milliseconds: 200),
  child: Icon(Icons.animation),
)
```

Available animations: `fade` (default), `scale`, `scaleAndFade`, `none`

### Barrier / Backdrop

```dart
WidgetTooltip(
  message: Text('With barrier!'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  barrier: TooltipBarrier(
    color: Colors.black54,
    showBlur: true,
    sigmaX: 3.0,
    sigmaY: 3.0,
  ),
  child: Icon(Icons.info),
)
```

### Close Button

```dart
WidgetTooltip(
  message: Text('With close button'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  dismissMode: WidgetTooltipDismissMode.manual,
  closeButton: TooltipCloseButton(
    position: CloseButtonPosition.inside,
    color: Colors.white,
    size: 18,
  ),
  child: Icon(Icons.info),
)
```

### Shadows

```dart
WidgetTooltip(
  message: Text('Shadow tooltip'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  messageDecoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  ),
  shadows: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ],
  child: Icon(Icons.info),
)
```

### Decoration Builder

```dart
WidgetTooltip(
  message: Text('Custom!'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  decorationBuilder: (child) => Card(
    elevation: 8,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: child,
    ),
  ),
  child: Icon(Icons.info),
)
```

### Separate Animation Durations

```dart
WidgetTooltip(
  message: Text('Slow in, fast out'),
  triggerMode: WidgetTooltipTriggerMode.tap,
  showAnimationDuration: Duration(milliseconds: 800),
  hideAnimationDuration: Duration(milliseconds: 150),
  child: Icon(Icons.info),
)
```

### Touch-Through Area

```dart
WidgetTooltip(
  message: Text('Tap the highlighted area!'),
  triggerMode: WidgetTooltipTriggerMode.manual,
  barrier: TooltipBarrier(
    color: Colors.black54,
    touchThroughArea: Rect.fromLTWH(50, 100, 200, 60),
    touchThroughAreaShape: ClipAreaShape.rectangle,
    touchThroughAreaCornerRadius: 8,
  ),
  child: Icon(Icons.info),
)
```

## API Reference

### WidgetTooltip

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `message` | `Widget` | required | Content displayed in tooltip |
| `child` | `Widget` | required | Target widget that triggers tooltip |
| `triggerMode` | `WidgetTooltipTriggerMode?` | `longPress` | How to trigger the tooltip |
| `dismissMode` | `WidgetTooltipDismissMode?` | `tapAnywhere` | How to dismiss the tooltip |
| `direction` | `WidgetTooltipDirection?` | auto | Tooltip direction (top/bottom/left/right) |
| `axis` | `Axis` | `vertical` | Tooltip axis |
| `autoFlip` | `bool` | `true` | Auto position based on screen center |
| `controller` | `TooltipController?` | null | Controller for manual control |
| `animation` | `WidgetTooltipAnimation` | `fade` | Animation type |
| `animationDuration` | `Duration` | 300ms | Animation duration |
| `autoDismissDuration` | `Duration?` | null | Auto dismiss after duration |
| `messageDecoration` | `BoxDecoration` | black rounded | Tooltip box decoration |
| `messagePadding` | `EdgeInsetsGeometry` | 8x16 | Padding inside tooltip |
| `triangleColor` | `Color` | black | Triangle indicator color |
| `triangleSize` | `Size` | 10x10 | Triangle indicator size |
| `triangleRadius` | `double` | 2 | Triangle corner radius |
| `targetPadding` | `double` | 4 | Gap between target and tooltip |
| `padding` | `EdgeInsetsGeometry` | 16 | Screen edge padding |
| `onShow` | `VoidCallback?` | null | Called when tooltip shows |
| `onDismiss` | `VoidCallback?` | null | Called when tooltip hides |
| `barrier` | `TooltipBarrier?` | null | Barrier/backdrop configuration |
| `closeButton` | `TooltipCloseButton?` | null | Close button configuration |
| `shadows` | `List<BoxShadow>?` | null | Tooltip box shadows |
| `decorationBuilder` | `Function?` | null | Custom decoration builder |
| `showAnimationDuration` | `Duration?` | null | Show animation duration override |
| `hideAnimationDuration` | `Duration?` | null | Hide animation duration override |
| `mouseCursor` | `MouseCursor?` | null | Cursor style on hover |
| `onLongPress` | `VoidCallback?` | null | Long press on tooltip content |
| ~~`touchThroughArea`~~ | `Rect?` | null | Deprecated: use `TooltipBarrier.touchThroughArea` |

### TooltipController

| Method | Description |
|--------|-------------|
| `show()` | Show the tooltip |
| `dismiss()` | Hide the tooltip |
| `toggle()` | Toggle visibility |
| `isShow` | Current visibility state |

## Platform Support

| Platform | Support |
|----------|---------|
| Android | ✅ |
| iOS | ✅ |
| Web | ✅ |
| macOS | ✅ |
| Windows | ✅ |
| Linux | ✅ |

## Requirements

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.2.5

## License

MIT License - see [LICENSE](LICENSE) for details.
