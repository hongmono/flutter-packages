import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'enums.dart';
import 'tooltip_animation_builder.dart';
import 'tooltip_barrier.dart';
import 'tooltip_close_button.dart';
import 'tooltip_controller.dart';
import 'triangles/tooltip_triangle.dart';

export 'enums.dart';
export 'tooltip_barrier.dart' show TooltipBarrier, ClipAreaShape;
export 'tooltip_close_button.dart' show TooltipCloseButton, CloseButtonPosition;
export 'tooltip_controller.dart';

/// A highly customizable tooltip widget that displays a message when triggered.
///
/// Uses a two-phase positioning approach (from v1.1.4):
/// 1. Renders the tooltip invisibly to measure its actual size
/// 2. Uses the measured size to calculate overflow-adjusted offsets
class WidgetTooltip extends StatefulWidget {
  const WidgetTooltip({
    super.key,
    required this.message,
    required this.child,
    this.triangleColor = Colors.black,
    this.triangleSize = const Size(10, 10),
    this.targetPadding = 4,
    this.triangleRadius = 2,
    this.onShow,
    this.onDismiss,
    this.controller,
    this.messagePadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.messageDecoration = const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(8))),
    this.padding = const EdgeInsets.all(16),
    this.axis = Axis.vertical,
    this.triggerMode,
    this.dismissMode,
    this.offsetIgnore = false,
    this.direction,
    this.animation = WidgetTooltipAnimation.fade,
    this.autoDismissDuration,
    this.animationDuration = const Duration(milliseconds: 300),
    this.autoFlip = true,
    this.dismissOnScroll = true,
    this.semanticLabel,
    this.showDelay,
    this.hideDelay,
    this.messageMaxWidth,
    this.barrier,
    this.closeButton,
    @Deprecated('Use TooltipBarrier.touchThroughArea instead')
    this.touchThroughArea,
    @Deprecated('Use TooltipBarrier.touchThroughAreaShape instead')
    this.touchThroughAreaShape = ClipAreaShape.rectangle,
    @Deprecated('Use TooltipBarrier.touchThroughAreaCornerRadius instead')
    this.touchThroughAreaCornerRadius = 0,
    this.decorationBuilder,
    this.showAnimationDuration,
    this.hideAnimationDuration,
    this.mouseCursor,
    this.onLongPress,
    this.shadows,
  }) : assert(messageMaxWidth == null || messageMaxWidth > 0);

  final Widget message;
  final Widget child;
  final Color triangleColor;
  final Size triangleSize;
  final double targetPadding;
  final double triangleRadius;
  final VoidCallback? onShow;
  final VoidCallback? onDismiss;
  final TooltipController? controller;
  final EdgeInsetsGeometry messagePadding;
  final BoxDecoration messageDecoration;
  final EdgeInsetsGeometry padding;
  final Axis axis;
  final WidgetTooltipTriggerMode? triggerMode;
  final WidgetTooltipDismissMode? dismissMode;
  final bool offsetIgnore;
  final WidgetTooltipDirection? direction;
  final WidgetTooltipAnimation animation;
  final Duration? autoDismissDuration;
  final Duration animationDuration;
  final bool autoFlip;

  /// Whether to automatically dismiss the tooltip when the nearest
  /// [Scrollable] ancestor scrolls.
  ///
  /// Defaults to `true`.
  final bool dismissOnScroll;

  /// An optional semantic label for the tooltip content.
  ///
  /// When provided, the tooltip overlay is wrapped in a [Semantics] widget
  /// and [SemanticsService.announce] is called when the tooltip appears,
  /// making the tooltip accessible to screen readers.
  final String? semanticLabel;

  /// The delay before showing the tooltip after a trigger event.
  ///
  /// When set, the tooltip will wait for this duration before appearing.
  /// If the tooltip is dismissed before the delay completes, the pending
  /// show is cancelled. Defaults to null (no delay).
  final Duration? showDelay;

  /// The delay before hiding the tooltip after a dismiss event.
  ///
  /// When set, the tooltip will wait for this duration before disappearing.
  /// If the tooltip is shown again before the delay completes, the pending
  /// hide is cancelled. Defaults to null (no delay).
  final Duration? hideDelay;

  /// The maximum width of the tooltip message box.
  ///
  /// When set, the tooltip message will be constrained to this width.
  /// If this value exceeds the available screen width (minus padding),
  /// the screen width constraint takes precedence. Defaults to null
  /// (uses screen width minus padding).
  final double? messageMaxWidth;

  /// Configuration for the background barrier overlay.
  ///
  /// When provided, a full-screen overlay is rendered behind the tooltip.
  /// Supports color tint and optional gaussian blur effect.
  /// Useful for guided tours and onboarding flows.
  final TooltipBarrier? barrier;

  /// Configuration for a close button on the tooltip.
  ///
  /// When provided, renders a close button that dismisses the tooltip.
  /// Can be positioned inside or outside the tooltip bubble.
  final TooltipCloseButton? closeButton;

  /// An area that allows touch events to pass through the barrier.
  ///
  /// Deprecated: Use [TooltipBarrier.touchThroughArea] instead.
  @Deprecated('Use TooltipBarrier.touchThroughArea instead')
  final Rect? touchThroughArea;

  /// The shape of the [touchThroughArea].
  ///
  /// Deprecated: Use [TooltipBarrier.touchThroughAreaShape] instead.
  @Deprecated('Use TooltipBarrier.touchThroughAreaShape instead')
  final ClipAreaShape touchThroughAreaShape;

  /// The corner radius of the [touchThroughArea].
  ///
  /// Deprecated: Use [TooltipBarrier.touchThroughAreaCornerRadius] instead.
  @Deprecated('Use TooltipBarrier.touchThroughAreaCornerRadius instead')
  final double touchThroughAreaCornerRadius;

  /// A builder that wraps the tooltip content with a custom decoration.
  ///
  /// When provided, this builder is used instead of the default [Container]
  /// with [messageDecoration] and [messagePadding]. The builder receives
  /// the [message] widget and should return the decorated version.
  final Widget Function(Widget child)? decorationBuilder;

  /// The duration for the show animation.
  ///
  /// When set, overrides [animationDuration] for the show direction only.
  /// The hide animation uses [hideAnimationDuration] or [animationDuration].
  final Duration? showAnimationDuration;

  /// The duration for the hide animation.
  ///
  /// When set, overrides [animationDuration] for the hide direction only.
  /// The show animation uses [showAnimationDuration] or [animationDuration].
  final Duration? hideAnimationDuration;

  /// The mouse cursor to use when hovering over the child widget.
  ///
  /// Only effective on platforms that support mouse input.
  final MouseCursor? mouseCursor;

  /// Called when the tooltip content is long-pressed.
  final VoidCallback? onLongPress;

  /// Box shadows applied to the tooltip message container.
  ///
  /// When provided, these shadows are added to the tooltip decoration.
  /// This is a convenience alternative to setting boxShadow in
  /// [messageDecoration] directly.
  ///
  /// Has no effect when [decorationBuilder] is used, since the builder
  /// is responsible for its own decoration.
  final List<BoxShadow>? shadows;

  @override
  State<WidgetTooltip> createState() => _WidgetTooltipState();
}

class _WidgetTooltipState extends State<WidgetTooltip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final TooltipController _controller;
  WidgetTooltipTriggerMode? _triggerMode;
  WidgetTooltipDismissMode? _dismissMode;
  Timer? _autoDismissTimer;
  Timer? _showDelayTimer;
  Timer? _hideDelayTimer;

  final _targetKey = GlobalKey();
  final _messageBoxKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _syncAnimationDurations();
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _controller = widget.controller ?? TooltipController();
    _controller.addListener(_listener);

    _initProperties();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeScrollListener();
    if (widget.dismissOnScroll) {
      _scrollPosition = Scrollable.maybeOf(context)?.position;
      _scrollPosition?.addListener(_onScroll);
    }
  }

  @override
  void didUpdateWidget(covariant WidgetTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initProperties();
    if (oldWidget.animationDuration != widget.animationDuration ||
        oldWidget.showAnimationDuration != widget.showAnimationDuration ||
        oldWidget.hideAnimationDuration != widget.hideAnimationDuration) {
      _syncAnimationDurations();
    }
    if (oldWidget.dismissOnScroll != widget.dismissOnScroll) {
      _removeScrollListener();
      if (widget.dismissOnScroll) {
        _scrollPosition = Scrollable.maybeOf(context)?.position;
        _scrollPosition?.addListener(_onScroll);
      }
    }
  }

  @override
  void dispose() {
    _cancelAutoDismissTimer();
    _showDelayTimer?.cancel();
    _hideDelayTimer?.cancel();
    _removeOverlay();
    _removeScrollListener();
    _controller.removeListener(_listener);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _removeScrollListener() {
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = null;
  }

  void _onScroll() {
    if (_overlayEntry != null) {
      _controller.dismiss();
    }
  }

  void _listener() {
    if (_controller.isShow) {
      _hideDelayTimer?.cancel();
      _hideDelayTimer = null;
      final showDelay = widget.showDelay;
      if (showDelay != null) {
        _showDelayTimer?.cancel();
        _showDelayTimer = Timer(showDelay, () {
          _showDelayTimer = null;
          _show();
        });
      } else {
        _show();
      }
    } else {
      _showDelayTimer?.cancel();
      _showDelayTimer = null;
      final hideDelay = widget.hideDelay;
      if (hideDelay != null) {
        _hideDelayTimer?.cancel();
        _hideDelayTimer = Timer(hideDelay, () {
          _hideDelayTimer = null;
          _dismiss();
        });
      } else {
        _dismiss();
      }
    }
  }

  void _syncAnimationDurations() {
    _animationController.duration =
        widget.showAnimationDuration ?? widget.animationDuration;
    _animationController.reverseDuration =
        widget.hideAnimationDuration ?? widget.animationDuration;
  }

  void _initProperties() {
    _triggerMode = widget.controller == null
        ? widget.triggerMode ?? WidgetTooltipTriggerMode.longPress
        : widget.triggerMode;

    _dismissMode = widget.controller == null
        ? widget.dismissMode ?? WidgetTooltipDismissMode.tapAnywhere
        : widget.dismissMode;
  }

  void _startAutoDismissTimer() {
    if (widget.autoDismissDuration != null) {
      _autoDismissTimer?.cancel();
      _autoDismissTimer = Timer(widget.autoDismissDuration!, () {
        _controller.dismiss();
      });
    }
  }

  void _cancelAutoDismissTimer() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(key: _targetKey, child: widget.child);

    if (_triggerMode == WidgetTooltipTriggerMode.hover) {
      child = MouseRegion(
        cursor: widget.mouseCursor ?? MouseCursor.defer,
        onEnter: (_) => _controller.show(),
        onExit: (_) => _controller.dismiss(),
        child: child,
      );
    } else if (widget.mouseCursor != null) {
      child = MouseRegion(
        cursor: widget.mouseCursor!,
        child: child,
      );
    }

    // Wrap child with Semantics hints based on trigger mode
    if (widget.semanticLabel != null) {
      child = Semantics(
        label: widget.semanticLabel,
        hint: _triggerMode == WidgetTooltipTriggerMode.longPress
            ? 'Long press to show tooltip'
            : _triggerMode == WidgetTooltipTriggerMode.tap
                ? 'Tap to show tooltip'
                : _triggerMode == WidgetTooltipTriggerMode.doubleTap
                    ? 'Double tap to show tooltip'
                    : null,
        child: child,
      );
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _triggerMode == WidgetTooltipTriggerMode.tap
            ? _controller.toggle
            : null,
        onLongPress: _triggerMode == WidgetTooltipTriggerMode.longPress
            ? _controller.toggle
            : null,
        onDoubleTap: _triggerMode == WidgetTooltipTriggerMode.doubleTap
            ? _controller.toggle
            : null,
        child: child,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Show / Dismiss
  // ---------------------------------------------------------------------------

  void _show() {
    if (_animationController.isAnimating) return;
    if (_overlayEntry != null) return;

    final resolvedPadding = widget.padding.resolve(Directionality.of(context));
    final horizontalPadding = resolvedPadding.left + resolvedPadding.right;

    final screenMaxWidth =
        MediaQuery.of(context).size.width - horizontalPadding;
    final effectiveMaxWidth = widget.messageMaxWidth != null
        ? min(widget.messageMaxWidth!, screenMaxWidth)
        : screenMaxWidth;

    // Build effective decoration with shadows merged in
    final effectiveDecoration = widget.shadows != null
        ? widget.messageDecoration.copyWith(
            boxShadow: [
              ...?widget.messageDecoration.boxShadow,
              ...widget.shadows!,
            ],
          )
        : widget.messageDecoration;

    final Widget messageContent = widget.decorationBuilder != null
        ? KeyedSubtree(
            key: _messageBoxKey,
            child: widget.decorationBuilder!(widget.message),
          )
        : Container(
            key: _messageBoxKey,
            padding: widget.messagePadding,
            decoration: effectiveDecoration,
            child: widget.message,
          );

    final Widget messageBox = Material(
      type: MaterialType.transparency,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: effectiveMaxWidth,
        ),
        child: messageContent,
      ),
    );

    // Phase 1: Insert invisible overlay to measure message box size.
    _overlayEntry = OverlayEntry(
      builder: (_) {
        return IgnorePointer(
          child: Opacity(
            opacity: 0,
            child: Stack(children: [messageBox]),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Phase 2: Measure → calculate position → build final overlay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final messageBoxRenderBox =
          _messageBoxKey.currentContext?.findRenderObject() as RenderBox?;
      final messageBoxSize = messageBoxRenderBox?.size;

      _overlayEntry?.remove();
      _overlayEntry = null;

      if (messageBoxSize == null) return;

      final textDirection = Directionality.of(context);
      final layout = _calculateLayout(messageBoxSize, textDirection);
      if (layout == null) return;

      _insertFinalOverlay(
        messageBox: messageBox,
        messageBoxSize: messageBoxSize,
        layout: layout,
      );

      if (widget.animation != WidgetTooltipAnimation.none) {
        _animationController.forward();
      } else {
        _animationController.value = 1.0;
      }

      // Announce tooltip content for screen readers
      if (widget.semanticLabel != null) {
        // ignore: deprecated_member_use, migrate to sendAnnouncement when minimum Flutter version is raised above 3.35
        SemanticsService.announce(
          widget.semanticLabel!,
          TextDirection.ltr,
        );
      }
    });

    _startAutoDismissTimer();
    widget.onShow?.call();
  }

  void _insertFinalOverlay({
    required Widget messageBox,
    required Size messageBoxSize,
    required _TooltipLayout layout,
  }) {
    final animationBuilder = TooltipAnimationBuilder(
      animation: widget.animation,
      animationValue: _animation,
    );

    final triangleDirection = switch (layout.targetAnchor) {
      Alignment.bottomCenter => AxisDirection.up,
      Alignment.topCenter => AxisDirection.down,
      Alignment.centerLeft => AxisDirection.right,
      Alignment.centerRight => AxisDirection.left,
      _ => AxisDirection.down,
    };

    final Widget triangle = SizedBox.fromSize(
      size: widget.triangleSize,
      child: TooltipTriangle(
        direction: triangleDirection,
        color: widget.triangleColor,
        radius: widget.triangleRadius,
      ),
    );

    final ts = widget.triangleSize;
    final combined = _buildCombinedTooltip(
      messageBox: messageBox,
      messageBoxSize: messageBoxSize,
      triangle: triangle,
      triangleSize: ts,
      layout: layout,
    );

    final scaleAlignment = _scaleAlignment(layout.targetAnchor);

    _overlayEntry = OverlayEntry(
      builder: (_) {
        Widget tooltipContent = combined.widget;

        // Wrap with close button if configured
        if (widget.closeButton != null) {
          tooltipContent = _buildWithCloseButton(
            child: tooltipContent,
            config: widget.closeButton!,
          );
        }

        // Wrap with onLongPress if configured
        if (widget.onLongPress != null) {
          tooltipContent = GestureDetector(
            onLongPress: widget.onLongPress,
            child: tooltipContent,
          );
        }

        tooltipContent = animationBuilder.build(
          scaleAlignment: scaleAlignment,
          child: widget.semanticLabel != null
              ? Semantics(
                  liveRegion: true,
                  label: widget.semanticLabel,
                  child: tooltipContent,
                )
              : tooltipContent,
        );

        return TapRegion(
          onTapInside: _shouldDismissOnTapInside() ? _controller.dismiss : null,
          onTapOutside: widget.barrier == null && _shouldDismissOnTapOutside()
              ? _controller.dismiss
              : null,
          child: Stack(
            children: [
              // Barrier
              if (widget.barrier != null)
                Positioned.fill(
                  child: FadeTransition(
                    opacity: _animation,
                    child: TooltipBarrierWidget(
                      config: _effectiveBarrier(),
                      onTap: _shouldDismissOnTapOutside()
                          ? () => _controller.dismiss()
                          : null,
                    ),
                  ),
                )
              else
                const SizedBox.expand(),
              CompositedTransformFollower(
                link: _layerLink,
                targetAnchor: layout.targetAnchor,
                followerAnchor: layout.followerAnchor,
                offset: combined.offset,
                child: tooltipContent,
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  ({Widget widget, Offset offset}) _buildCombinedTooltip({
    required Widget messageBox,
    required Size messageBoxSize,
    required Widget triangle,
    required Size triangleSize,
    required _TooltipLayout layout,
  }) {
    final dx = layout.dx;
    final dy = layout.dy;
    final ts = triangleSize;
    final isVertical = layout.targetAnchor == Alignment.bottomCenter ||
        layout.targetAnchor == Alignment.topCenter;

    if (!isVertical &&
        layout.targetAnchor != Alignment.centerRight &&
        layout.targetAnchor != Alignment.centerLeft) {
      return (widget: messageBox, offset: Offset.zero);
    }

    // Triangle position along the cross-axis
    final double triangleCrossPos = isVertical
        ? messageBoxSize.width / 2 - dx - ts.width / 2
        : messageBoxSize.height / 2 - dy - ts.height / 2;

    // Determine padding and positioning based on direction
    final ({EdgeInsets padding, Map<String, double?> position, Offset offset})
        dirConfig = switch (layout.targetAnchor) {
      Alignment.bottomCenter => (
          padding: EdgeInsets.only(top: ts.height - 1),
          position: {'top': 0.0, 'left': triangleCrossPos},
          offset: Offset(dx, widget.targetPadding),
        ),
      Alignment.topCenter => (
          padding: EdgeInsets.only(bottom: ts.height - 1),
          position: {'bottom': 0.0, 'left': triangleCrossPos},
          offset: Offset(dx, -widget.targetPadding),
        ),
      Alignment.centerRight => (
          padding: EdgeInsets.only(left: ts.width - 1),
          position: {'left': 0.0, 'top': triangleCrossPos},
          offset: Offset(widget.targetPadding, dy),
        ),
      Alignment.centerLeft => (
          padding: EdgeInsets.only(right: ts.width - 1),
          position: {'right': 0.0, 'top': triangleCrossPos},
          offset: Offset(-widget.targetPadding, dy),
        ),
      _ => throw StateError('Unreachable'),
    };

    return (
      widget: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(padding: dirConfig.padding, child: messageBox),
          Positioned(
            top: dirConfig.position['top'],
            bottom: dirConfig.position['bottom'],
            left: dirConfig.position['left'],
            right: dirConfig.position['right'],
            child: triangle,
          ),
        ],
      ),
      offset: dirConfig.offset,
    );
  }

  Widget _buildWithCloseButton({
    required Widget child,
    required TooltipCloseButton config,
  }) {
    final isOutside = config.position == CloseButtonPosition.outside;
    final halfSize = config.size / 2;

    final closeIcon = Semantics(
      button: true,
      label: 'Close tooltip',
      child: GestureDetector(
        onTap: () => _controller.dismiss(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.close,
            size: config.size,
            color: config.color,
          ),
        ),
      ),
    );

    return Stack(
      clipBehavior: isOutside ? Clip.none : Clip.hardEdge,
      children: [
        child,
        Positioned(
          top: isOutside ? -halfSize : 4,
          right: isOutside ? -halfSize : 4,
          child: closeIcon,
        ),
      ],
    );
  }

  Future<void> _dismiss() async {
    _cancelAutoDismissTimer();
    if (_overlayEntry == null) return;

    try {
      if (widget.animation != WidgetTooltipAnimation.none) {
        await _animationController.reverse();
      }
    } catch (_) {
      // May fail if disposed during animation
    } finally {
      _removeOverlay();
      widget.onDismiss?.call();
    }
  }

  /// Removes the overlay entry without animation. Safe to call multiple times.
  void _removeOverlay() {
    try {
      _overlayEntry?.remove();
    } catch (_) {
      // Overlay may already be removed
    }
    _overlayEntry = null;
  }

  // ---------------------------------------------------------------------------
  // Layout calculation
  // ---------------------------------------------------------------------------

  _TooltipLayout? _calculateLayout(
      Size messageBoxSize, TextDirection textDirection) {
    final renderBox =
        _targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final safePadding = mediaQuery.padding;

    final targetSize = renderBox.size;
    final targetPosition = renderBox.localToGlobal(Offset.zero);

    final anchors = _resolveAnchors(
      targetPosition: targetPosition,
      targetSize: targetSize,
      textDirection: textDirection,
      screenSize: screenSize,
    );
    final offsets = _resolveOffsets(
      messageBoxSize: messageBoxSize,
      targetSize: targetSize,
      targetPosition: targetPosition,
      screenSize: screenSize,
      safePadding: safePadding,
      isTop: anchors.isTop,
      isBottom: anchors.isBottom,
      isLeft: anchors.isLeft,
      isRight: anchors.isRight,
    );

    return _TooltipLayout(
      targetAnchor: anchors.targetAnchor,
      followerAnchor: anchors.followerAnchor,
      dx: widget.offsetIgnore ? 0.0 : offsets.dx,
      dy: widget.offsetIgnore ? 0.0 : offsets.dy,
    );
  }

  ({
    Alignment targetAnchor,
    Alignment followerAnchor,
    bool isTop,
    bool isBottom,
    bool isLeft,
    bool isRight,
  }) _resolveAnchors({
    required Offset targetPosition,
    required Size targetSize,
    required TextDirection textDirection,
    required Size screenSize,
  }) {
    final targetCenter = Offset(
      targetPosition.dx + targetSize.width / 2,
      targetPosition.dy + targetSize.height / 2,
    );

    final bool isRtl = textDirection == TextDirection.rtl;
    final bool inLeftHalf = targetCenter.dx <= screenSize.width / 2;

    final bool isLeft = switch (widget.direction) {
      WidgetTooltipDirection.left => false,
      WidgetTooltipDirection.right => true,
      _ => widget.autoFlip ? (isRtl ? !inLeftHalf : inLeftHalf) : true,
    };

    final bool isRight = switch (widget.direction) {
      WidgetTooltipDirection.left => true,
      WidgetTooltipDirection.right => false,
      _ => widget.autoFlip ? (isRtl ? inLeftHalf : !inLeftHalf) : false,
    };

    final bool isBottom = switch (widget.direction) {
      WidgetTooltipDirection.top => true,
      WidgetTooltipDirection.bottom => false,
      _ =>
        widget.autoFlip ? targetCenter.dy > screenSize.height / 2 : false,
    };

    final bool isTop = switch (widget.direction) {
      WidgetTooltipDirection.top => false,
      WidgetTooltipDirection.bottom => true,
      _ =>
        widget.autoFlip ? targetCenter.dy <= screenSize.height / 2 : true,
    };

    final Alignment targetAnchor = switch (widget.axis) {
      Axis.horizontal when isRight => Alignment.centerLeft,
      Axis.horizontal when isLeft => Alignment.centerRight,
      Axis.vertical when isTop => Alignment.bottomCenter,
      Axis.vertical when isBottom => Alignment.topCenter,
      _ => Alignment.center,
    };

    final Alignment followerAnchor = switch (widget.axis) {
      Axis.horizontal when isRight => Alignment.centerRight,
      Axis.horizontal when isLeft => Alignment.centerLeft,
      Axis.vertical when isTop => Alignment.topCenter,
      Axis.vertical when isBottom => Alignment.bottomCenter,
      _ => Alignment.center,
    };

    return (
      targetAnchor: targetAnchor,
      followerAnchor: followerAnchor,
      isTop: isTop,
      isBottom: isBottom,
      isLeft: isLeft,
      isRight: isRight,
    );
  }

  ({double dx, double dy}) _resolveOffsets({
    required Size messageBoxSize,
    required Size targetSize,
    required Offset targetPosition,
    required Size screenSize,
    required EdgeInsets safePadding,
    required bool isTop,
    required bool isBottom,
    required bool isLeft,
    required bool isRight,
  }) {
    // Horizontal overflow adjustment
    final double overflowWidth = (messageBoxSize.width - targetSize.width) / 2;
    final edgeFromLeft = targetPosition.dx - overflowWidth;
    final edgeFromRight = screenSize.width -
        (targetPosition.dx + targetSize.width + overflowWidth);
    final edgeFromHorizontal = min(edgeFromLeft, edgeFromRight);

    double dx = 0;
    if (edgeFromHorizontal < widget.padding.horizontal / 2) {
      if (isLeft) {
        dx = safePadding.left +
            (widget.padding.horizontal / 2) -
            edgeFromHorizontal;
      } else if (isRight) {
        dx = -safePadding.right -
            (widget.padding.horizontal / 2) +
            edgeFromHorizontal;
      }
    }

    // Vertical overflow adjustment
    final double overflowHeight =
        (messageBoxSize.height - targetSize.height) / 2;
    final edgeFromTop = targetPosition.dy - overflowHeight;
    final edgeFromBottom = screenSize.height -
        (targetPosition.dy + targetSize.height + overflowHeight);
    final edgeFromVertical = min(edgeFromTop, edgeFromBottom);

    double dy = 0;
    if (edgeFromVertical < widget.padding.vertical / 2) {
      if (isTop) {
        dy = safePadding.top + (widget.padding.vertical / 2) - edgeFromVertical;
      } else if (isBottom) {
        dy = safePadding.bottom -
            (widget.padding.vertical / 2) +
            edgeFromVertical;
      }
    }

    return (dx: dx, dy: dy);
  }

  Alignment _scaleAlignment(Alignment targetAnchor) {
    return switch (targetAnchor) {
      Alignment.topCenter => Alignment.bottomCenter,
      Alignment.bottomCenter => Alignment.topCenter,
      Alignment.centerLeft => Alignment.centerRight,
      Alignment.centerRight => Alignment.centerLeft,
      _ => Alignment.center,
    };
  }

  /// Resolves the effective barrier config, merging deprecated top-level
  /// touchThrough params into the barrier config if needed.
  TooltipBarrier _effectiveBarrier() {
    final barrier = widget.barrier!;
    // If barrier already has touchThrough config, use it directly
    if (barrier.touchThroughArea != null) return barrier;
    // Fall back to deprecated top-level params
    // ignore: deprecated_member_use_from_same_package
    final legacyArea = widget.touchThroughArea;
    if (legacyArea == null) return barrier;
    return TooltipBarrier(
      color: barrier.color,
      showBlur: barrier.showBlur,
      sigmaX: barrier.sigmaX,
      sigmaY: barrier.sigmaY,
      touchThroughArea: legacyArea,
      // ignore: deprecated_member_use_from_same_package
      touchThroughAreaShape: widget.touchThroughAreaShape,
      // ignore: deprecated_member_use_from_same_package
      touchThroughAreaCornerRadius: widget.touchThroughAreaCornerRadius,
    );
  }

  bool _shouldDismissOnTapInside() =>
      _matchesDismissMode(WidgetTooltipDismissMode.tapInside);

  bool _shouldDismissOnTapOutside() =>
      _matchesDismissMode(WidgetTooltipDismissMode.tapOutside);

  bool _matchesDismissMode(WidgetTooltipDismissMode mode) {
    return _dismissMode == mode ||
        _dismissMode == WidgetTooltipDismissMode.tapAnywhere ||
        // ignore: deprecated_member_use_from_same_package
        _dismissMode == WidgetTooltipDismissMode.tapAnyWhere;
  }
}

/// Internal layout result for tooltip positioning.
class _TooltipLayout {
  const _TooltipLayout({
    required this.targetAnchor,
    required this.followerAnchor,
    required this.dx,
    required this.dy,
  });

  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final double dx;
  final double dy;
}
