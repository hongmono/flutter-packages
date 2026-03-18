import 'package:flutter/material.dart';

/// Position of the close button relative to the tooltip.
enum CloseButtonPosition {
  /// Close button is inside the tooltip bubble.
  inside,

  /// Close button is outside the tooltip bubble (top-right corner).
  outside,
}

/// Configuration for the tooltip's close button.
///
/// When provided to [WidgetTooltip.closeButton], a close button is
/// rendered on the tooltip that dismisses it when tapped.
///
/// Example:
/// ```dart
/// WidgetTooltip(
///   closeButton: const TooltipCloseButton(
///     position: CloseButtonPosition.inside,
///     color: Colors.white,
///     size: 20,
///   ),
///   message: Text('Hello'),
///   child: Icon(Icons.info),
/// )
/// ```
class TooltipCloseButton {
  const TooltipCloseButton({
    this.position = CloseButtonPosition.inside,
    this.color,
    this.size = 18,
  });

  /// Where to place the close button.
  final CloseButtonPosition position;

  /// The color of the close icon. Defaults to the current icon theme color.
  final Color? color;

  /// The size of the close icon.
  final double size;
}
