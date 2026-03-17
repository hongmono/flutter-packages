# DraggableFloat

A draggable floating widget for Flutter that can be repositioned anywhere on screen with boundary constraints, snap-to-edge behavior, and smooth animations.

## Features

- 🖱️ **Draggable** — freely move any widget around the screen
- 📐 **Boundary clamping** — floating widget stays within configurable padding
- 🧲 **Snap to edge** — optionally snap to the nearest horizontal edge on release
- 🎞️ **Smooth animations** — animated transitions when snapping or clamping
- 📍 **Initial alignment** — place the widget at predefined positions (e.g. `bottomRight`)
- 📡 **Position callback** — get notified whenever the position changes

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  draggable_float:
    path: packages/draggable_float  # or your preferred source
```

## Usage

### Basic

```dart
FloatingWidget(
  floatingWidget: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  child: Scaffold(
    body: Center(child: Text('Hello World')),
  ),
)
```

### Snap to Edge

The floating widget animates to the nearest left or right edge when released:

```dart
FloatingWidget(
  floatingWidget: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.chat),
  ),
  snapToEdge: true,
  padding: EdgeInsets.all(16),
  child: YourContent(),
)
```

### Initial Alignment

Use `initialAlignment` instead of calculating raw offsets:

```dart
FloatingWidget(
  floatingWidget: MyWidget(),
  initialAlignment: FloatingAlignment.bottomRight,
  padding: EdgeInsets.all(16),
  child: YourContent(),
)
```

### Position Callback

```dart
FloatingWidget(
  floatingWidget: MyWidget(),
  onPositionChanged: (offset) {
    print('Floating widget moved to: $offset');
  },
  child: YourContent(),
)
```

## API Reference

### FloatingWidget

| Property | Type | Default | Description |
|---|---|---|---|
| `floatingWidget` | `Widget` | **required** | The draggable floating widget |
| `child` | `Widget` | **required** | The main content beneath the floating widget |
| `initialPosition` | `Offset` | `Offset.zero` | Starting position (ignored if `initialAlignment` is set) |
| `initialAlignment` | `FloatingAlignment?` | `null` | Predefined starting alignment |
| `padding` | `EdgeInsets` | `EdgeInsets.zero` | Inset from screen edges for boundary clamping |
| `snapToEdge` | `bool` | `false` | Snap to nearest horizontal edge on release |
| `snapAnimationDuration` | `Duration` | `300ms` | Duration of snap/clamp animation |
| `snapAnimationCurve` | `Curve` | `Curves.easeOut` | Animation curve for snap/clamp |
| `onPositionChanged` | `ValueChanged<Offset>?` | `null` | Called when position changes after drag |

### FloatingAlignment

| Value | Description |
|---|---|
| `topLeft` | Top-left corner |
| `topCenter` | Top-center |
| `topRight` | Top-right corner |
| `centerLeft` | Center-left |
| `center` | Center |
| `centerRight` | Center-right |
| `bottomLeft` | Bottom-left corner |
| `bottomCenter` | Bottom-center |
| `bottomRight` | Bottom-right corner |

## License

MIT — see [LICENSE](LICENSE) for details.
