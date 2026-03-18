import 'package:flutter/material.dart';
import 'package:widget_tooltip/widget_tooltip.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TooltipExample());
  }
}

class TooltipExample extends StatelessWidget {
  const TooltipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Tooltip Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Basic tooltip with tap trigger
            WidgetTooltip(
              message: const Text(
                'Hello from tooltip!',
                style: TextStyle(color: Colors.white),
              ),
              triggerMode: WidgetTooltipTriggerMode.tap,
              messageDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              triangleColor: Colors.blue,
              child: const Icon(Icons.info, size: 40),
            ),
            const SizedBox(height: 48),

            // Tooltip with barrier and close button
            WidgetTooltip(
              message: const Text(
                'With barrier and close button!',
                style: TextStyle(color: Colors.white),
              ),
              triggerMode: WidgetTooltipTriggerMode.tap,
              dismissMode: WidgetTooltipDismissMode.manual,
              barrier: const TooltipBarrier(color: Colors.black54),
              closeButton: const TooltipCloseButton(
                position: CloseButtonPosition.inside,
                color: Colors.white70,
              ),
              messageDecoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(8),
              ),
              triangleColor: Colors.deepPurple,
              child: const Icon(Icons.star, size: 40),
            ),
            const SizedBox(height: 48),

            // Tooltip with custom decoration builder
            WidgetTooltip(
              message: const Text('Custom card tooltip'),
              triggerMode: WidgetTooltipTriggerMode.tap,
              decorationBuilder: (child) => Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              ),
              triangleColor: Colors.white,
              child: const Icon(Icons.palette, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
