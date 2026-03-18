import 'package:flutter/material.dart';
import 'package:burst_icon_button/burst_icon_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BurstButtonExample());
  }
}

class BurstButtonExample extends StatefulWidget {
  const BurstButtonExample({super.key});

  @override
  State<BurstButtonExample> createState() => _BurstButtonExampleState();
}

class _BurstButtonExampleState extends State<BurstButtonExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Burst Icon Button Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Count: $_count', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 32),

            // Basic burst icon button
            BurstIconButton(
              icon: const Icon(Icons.favorite, color: Colors.red, size: 40),
              burstIcon:
                  const Icon(Icons.favorite, color: Colors.red, size: 20),
              onPressed: () => setState(() => _count++),
              burstCount: 3,
              burstDistance: 120,
            ),
            const SizedBox(height: 32),

            // With pressed icon
            BurstIconButton(
              icon: const Icon(Icons.thumb_up, color: Colors.blue, size: 40),
              pressedIcon:
                  const Icon(Icons.thumb_up, color: Colors.indigo, size: 44),
              burstIcon:
                  const Icon(Icons.thumb_up, color: Colors.blue, size: 16),
              onPressed: () {},
              burstCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
