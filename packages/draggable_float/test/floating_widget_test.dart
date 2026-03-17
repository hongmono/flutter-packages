import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:draggable_float/draggable_float.dart';

Widget buildApp({
  Offset initialPosition = Offset.zero,
  FloatingAlignment? initialAlignment,
  EdgeInsets padding = EdgeInsets.zero,
  bool snapToEdge = false,
  SnapDirection? snapDirection,
  ValueChanged<Offset>? onPositionChanged,
  Widget? floatingWidget,
  FloatingWidgetController? controller,
}) {
  return MaterialApp(
    home: FloatingWidget(
      initialPosition: initialPosition,
      initialAlignment: initialAlignment,
      padding: padding,
      snapToEdge: snapToEdge,
      snapDirection: snapDirection,
      onPositionChanged: onPositionChanged,
      controller: controller,
      floatingWidget: floatingWidget ??
          Container(
            key: const Key('floating'),
            width: 56,
            height: 56,
            color: Colors.blue,
          ),
      child: Container(
        key: const Key('content'),
        color: Colors.white,
        child: const Center(child: Text('Content')),
      ),
    ),
  );
}

void main() {
  group('FloatingWidget', () {
    testWidgets('renders floating widget and child', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      expect(find.text('Content'), findsOneWidget);
      expect(find.byKey(const Key('floating')), findsOneWidget);
    });

    testWidgets('uses initialPosition', (tester) async {
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(100, 200),
      ));
      await tester.pumpAndSettle();

      final positioned = tester
          .widgetList<Positioned>(
            find.byType(Positioned),
          )
          .last;
      expect(positioned.left, 100);
      expect(positioned.top, 200);
    });

    testWidgets('drag updates position', (tester) async {
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(100, 100),
      ));
      await tester.pumpAndSettle();

      // Use timedDragFrom to simulate the gesture at the exact position
      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(50, 30),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned = tester
          .widgetList<Positioned>(
            find.byType(Positioned),
          )
          .last;
      expect(positioned.left, closeTo(150, 2));
      expect(positioned.top, closeTo(130, 2));
    });

    testWidgets('clamps position to screen bounds', (tester) async {
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(10, 10),
        padding: const EdgeInsets.all(20),
      ));
      await tester.pumpAndSettle();

      // Drag far to the left/top (beyond bounds)
      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(-500, -500),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned = tester
          .widgetList<Positioned>(
            find.byType(Positioned),
          )
          .last;
      expect(positioned.left! >= 20, isTrue);
      expect(positioned.top! >= 20, isTrue);
    });

    testWidgets('snapToEdge snaps to nearest horizontal edge', (tester) async {
      // Screen is 800x600 in tests
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(300, 200),
        snapToEdge: true,
        padding: const EdgeInsets.all(16),
      ));
      await tester.pumpAndSettle();

      // Drag slightly right then release
      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(10, 0),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned = tester
          .widgetList<Positioned>(
            find.byType(Positioned),
          )
          .last;

      // Center of 800 is ~400, widget at ~310 should snap to left edge (16)
      // midpoint = (16 + 728) / 2 = 372, 310 < 372 => snaps left
      expect(positioned.left, closeTo(16, 2));
    });

    testWidgets('onPositionChanged is called after drag', (tester) async {
      Offset? lastPosition;
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(100, 100),
        onPositionChanged: (pos) => lastPosition = pos,
      ));
      await tester.pumpAndSettle();

      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(50, 50),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      expect(lastPosition, isNotNull);
    });

    testWidgets('initialAlignment positions widget correctly', (tester) async {
      await tester.pumpWidget(buildApp(
        initialAlignment: FloatingAlignment.topLeft,
        padding: const EdgeInsets.all(10),
      ));
      await tester.pumpAndSettle();

      final positioned = tester
          .widgetList<Positioned>(
            find.byType(Positioned),
          )
          .last;
      expect(positioned.left, closeTo(10, 1));
      expect(positioned.top, closeTo(10, 1));
    });

    testWidgets('disposes animation controller without error', (tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      // Replace with a different widget to trigger dispose
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: Text('Replaced')),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Replaced'), findsOneWidget);
    });

    testWidgets('negative bounds clamping with oversized widget',
        (tester) async {
      // Widget (500x500) is larger than screen minus padding,
      // so maxX/maxY would be negative without the fix.
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(100, 100),
        padding: const EdgeInsets.all(200),
        floatingWidget: Container(
          key: const Key('floating'),
          width: 500,
          height: 500,
          color: Colors.blue,
        ),
      ));
      await tester.pumpAndSettle();

      // Drag and release to trigger clamping
      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(50, 50),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned =
          tester.widgetList<Positioned>(find.byType(Positioned)).last;
      // Position should be clamped to minX (200), not negative
      expect(positioned.left! >= 200, isTrue);
      expect(positioned.top! >= 200, isTrue);
    });

    testWidgets('vertical snap to edge', (tester) async {
      // Screen is 800x600 in tests
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(200, 200),
        snapDirection: SnapDirection.vertical,
        padding: const EdgeInsets.all(16),
      ));
      await tester.pumpAndSettle();

      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(0, 10),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned =
          tester.widgetList<Positioned>(find.byType(Positioned)).last;

      // Widget at ~210, midY = (16 + 528) / 2 = 272, 210 < 272 => snaps top
      expect(positioned.top, closeTo(16, 2));
      // X should not snap
      expect(positioned.left, closeTo(200, 5));
    });

    testWidgets('both-axis snap', (tester) async {
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(200, 200),
        snapDirection: SnapDirection.both,
        padding: const EdgeInsets.all(16),
      ));
      await tester.pumpAndSettle();

      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(10, 10),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned =
          tester.widgetList<Positioned>(find.byType(Positioned)).last;

      // Both axes should snap to edges
      // X: 210 < midX (~372) => snaps left (16)
      expect(positioned.left, closeTo(16, 2));
      // Y: 210 < midY (~272) => snaps top (16)
      expect(positioned.top, closeTo(16, 2));
    });

    testWidgets('SnapDirection.none overrides snapToEdge', (tester) async {
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(200, 200),
        snapToEdge: true,
        snapDirection: SnapDirection.none,
      ));
      await tester.pumpAndSettle();

      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(30, 0),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned =
          tester.widgetList<Positioned>(find.byType(Positioned)).last;

      // Should stay near 230, not snap to edge
      expect(positioned.left, closeTo(230, 5));
    });

    testWidgets('FloatingWidgetController.setPosition animated',
        (tester) async {
      final controller = FloatingWidgetController();
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(100, 100),
        controller: controller,
      ));
      await tester.pumpAndSettle();

      expect(controller.currentPosition, const Offset(100, 100));

      controller.setPosition(const Offset(300, 300));
      await tester.pumpAndSettle();

      expect(controller.currentPosition.dx, closeTo(300, 2));
      expect(controller.currentPosition.dy, closeTo(300, 2));
    });

    testWidgets('FloatingWidgetController.setPosition immediate',
        (tester) async {
      final controller = FloatingWidgetController();
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(100, 100),
        controller: controller,
      ));
      await tester.pumpAndSettle();

      controller.setPosition(const Offset(200, 200), animate: false);
      await tester.pump();

      expect(controller.currentPosition.dx, closeTo(200, 2));
      expect(controller.currentPosition.dy, closeTo(200, 2));
    });

    testWidgets('controller currentPosition when detached', (tester) async {
      final controller = FloatingWidgetController();
      // Not attached to any widget
      expect(controller.currentPosition, Offset.zero);

      // Attach then detach
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(50, 50),
        controller: controller,
      ));
      await tester.pumpAndSettle();
      expect(controller.currentPosition, const Offset(50, 50));

      // Replace widget to trigger detach
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: Text('Replaced')),
      ));
      await tester.pumpAndSettle();

      // After detach, should return Offset.zero
      expect(controller.currentPosition, Offset.zero);
    });

    testWidgets('snapToEdge false does not snap', (tester) async {
      await tester.pumpWidget(buildApp(
        initialPosition: const Offset(200, 200),
        snapToEdge: false,
      ));
      await tester.pumpAndSettle();

      final center = tester.getCenter(find.byKey(const Key('floating')));
      await tester.timedDragFrom(
        center,
        const Offset(30, 0),
        const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();

      final positioned = tester
          .widgetList<Positioned>(
            find.byType(Positioned),
          )
          .last;
      // Should stay near 230, not snap to edge
      expect(positioned.left, closeTo(230, 5));
    });
  });
}
