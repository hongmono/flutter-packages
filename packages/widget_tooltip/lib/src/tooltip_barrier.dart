import 'dart:ui';

import 'package:flutter/material.dart';

/// Configuration for the tooltip's background barrier overlay.
///
/// When provided to [WidgetTooltip.barrier], a full-screen overlay is
/// rendered behind the tooltip, optionally with color tint and blur effect.
///
/// Example:
/// ```dart
/// WidgetTooltip(
///   barrier: const TooltipBarrier(
///     color: Colors.black54,
///     showBlur: true,
///     sigmaX: 3.0,
///     sigmaY: 3.0,
///   ),
///   message: Text('Hello'),
///   child: Icon(Icons.info),
/// )
/// ```
class TooltipBarrier {
  const TooltipBarrier({
    this.color = Colors.black54,
    this.showBlur = false,
    this.sigmaX = 5.0,
    this.sigmaY = 5.0,
    this.touchThroughArea,
    this.touchThroughAreaShape = ClipAreaShape.rectangle,
    this.touchThroughAreaCornerRadius = 0,
  });

  /// The color of the barrier overlay.
  final Color color;

  /// Whether to apply a gaussian blur effect to the background.
  final bool showBlur;

  /// Horizontal blur sigma. Only used when [showBlur] is true.
  final double sigmaX;

  /// Vertical blur sigma. Only used when [showBlur] is true.
  final double sigmaY;

  /// An area that allows touch events to pass through the barrier.
  ///
  /// Useful for guided tours where the user should be able to interact
  /// with a specific area behind the barrier.
  final Rect? touchThroughArea;

  /// The shape of the [touchThroughArea].
  final ClipAreaShape touchThroughAreaShape;

  /// The corner radius of the [touchThroughArea] when shape is
  /// [ClipAreaShape.rectangle].
  final double touchThroughAreaCornerRadius;
}

/// A widget that renders the barrier overlay behind the tooltip.
class TooltipBarrierWidget extends StatelessWidget {
  const TooltipBarrierWidget({
    super.key,
    required this.config,
    this.onTap,
  });

  final TooltipBarrier config;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget barrier = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(color: config.color),
    );

    if (config.showBlur) {
      barrier = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: config.sigmaX, sigmaY: config.sigmaY),
        child: barrier,
      );
    }

    if (config.touchThroughArea != null) {
      barrier = ClipPath(
        clipper: _TouchThroughClipper(
          area: config.touchThroughArea!,
          shape: config.touchThroughAreaShape,
          cornerRadius: config.touchThroughAreaCornerRadius,
        ),
        child: barrier,
      );
    }

    return barrier;
  }
}

/// Shape of the touch-through area.
enum ClipAreaShape {
  /// Rectangular passthrough area.
  rectangle,

  /// Oval passthrough area.
  oval,
}

class _TouchThroughClipper extends CustomClipper<Path> {
  _TouchThroughClipper({
    required this.area,
    required this.shape,
    required this.cornerRadius,
  });

  final Rect area;
  final ClipAreaShape shape;
  final double cornerRadius;

  @override
  Path getClip(Size size) {
    final outerPath = Path()..addRect(Offset.zero & size);

    final holePath = Path();
    switch (shape) {
      case ClipAreaShape.rectangle:
        holePath.addRRect(
          RRect.fromRectAndRadius(area, Radius.circular(cornerRadius)),
        );
      case ClipAreaShape.oval:
        holePath.addOval(area);
    }

    return Path.combine(PathOperation.difference, outerPath, holePath);
  }

  @override
  bool shouldReclip(covariant _TouchThroughClipper oldClipper) {
    return oldClipper.area != area ||
        oldClipper.shape != shape ||
        oldClipper.cornerRadius != cornerRadius;
  }
}
